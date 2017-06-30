/* Motion
 *
 * various functions to assist in analyzing the images
 * coming in from the webcam, motion detection
 */
import java.util.PriorityQueue;

float MAX_PIXEL_CHANGE = 442;      // sqrt(255^2 + 255^2 + 255^2) ~= 442
float MOTION_THRESHOLD = 80f;      // reasonable threshold to ignore webcam pixel noise that is always present 

boolean movementDetected = false;                          // true if some significant amount of motion was detected
PVector maxMotionLocation = new PVector(0, 0);             // a single location on screen with the most motion
MotionPixel[] top100MotionPixels = new MotionPixel[] {};   // array of pixels that are the most motiony

PImage previousProcessingFrame; // smaller frame for image processing / previous frame
PImage processingFrame;         // smaller frame for image processing
PImage motionImage;             // only shows pixels that have changed since the previous frame
PImage motionImageAlphaChannel; // same as motionImage except each pixel has an alpha channel that varies depending on amount of motion

int totalPixels = 0;           // total count of pixels in webcam image
int numberOfMotionPixels = 0;  // total count of pixels in motion
float percentMotion = 0;       // percent of pixels in motion [0..1]
float amountOfMotion = 0;      // a more useful measure of amount of motion than percentMotion [0..1]
color transparentBlack;        // just a cached color

void performMotionDetection(PImage c) {
  // initialize empty images for the first time
  if (previousProcessingFrame == null) {
    previousProcessingFrame = createImage(c.width / 4, c.height / 4, RGB);
    processingFrame = createImage(c.width / 4, c.height / 4, RGB);
    motionImage = createImage(c.width / 4, c.height / 4, ARGB);
    motionImageAlphaChannel = createImage(c.width / 4, c.height / 4, ARGB);
    transparentBlack = color(0, 0, 0, 0);
    totalPixels = motionImage.width * motionImage.height;
  }

  // save off previous frame
  previousProcessingFrame.copy(processingFrame, 0, 0, processingFrame.width, processingFrame.height, 0, 0, previousProcessingFrame.width, previousProcessingFrame.height);

  // copy capture frame over to current frame variable, and shrink down in size
  processingFrame.copy(c, 0, 0, c.width, c.height, 0, 0, processingFrame.width, processingFrame.height);

  if (captureFrameNumber > 0 /* we need at least two frames for frame differencing */) {
    detectMotion();
    cameraReady = true; // once we have detected motion for the first time we are ready
  }
}

void detectMotion() {
  processingFrame.loadPixels();
  previousProcessingFrame.loadPixels();
  motionImage.loadPixels();
  motionImageAlphaChannel.loadPixels();

  MotionPixels motionPixels = new MotionPixels();

  float maxChange = 0;
  boolean newMotion = false;
  int newX = 0;
  int newY = 0;
  numberOfMotionPixels = 0;
  for (int x = 0; x < previousProcessingFrame.width; x++) {
    for (int y = 0; y < previousProcessingFrame.height; y++) {
      int loc = x + y * previousProcessingFrame.width; //1D pixel location

      // pull out red, green, blue values using fast bit-wise operations, see https://processing.org/reference/blue_.html, etc…
      float oldR = previousProcessingFrame.pixels[loc] >> 16 & 0xFF;
      float oldG = previousProcessingFrame.pixels[loc] >> 8 & 0xFF;
      float oldB = previousProcessingFrame.pixels[loc] & 0xFF;
      float newR = processingFrame.pixels[loc] >> 16 & 0xFF;
      float newG = processingFrame.pixels[loc] >> 8 & 0xFF;
      float newB = processingFrame.pixels[loc] & 0xFF;

      float change = dist(oldR, oldG, oldB, newR, newG, newB);
      if (change > MOTION_THRESHOLD) {
        numberOfMotionPixels++;

        if (change > maxChange) {
          newMotion = true;
          newX = x;
          newY = y;
        }
        float pixelPctChange = change / MAX_PIXEL_CHANGE;
        float pixelChange = pixelPctChange / (pixelPctChange + 0.1);
        
        int changeInt = constrain(round(pixelChange * 255.0), 0, 255);
        // color of motion image is current color
        // with alpha channel modulated based on the amount of motion
        motionImage.pixels[loc] = color(newR, newG, newB);
        motionImageAlphaChannel.pixels[loc] = color(newR, newG, newB, changeInt);
        PVector newXYProcessingCoordinates = new PVector(x, y);
        motionPixels.add(new MotionPixel(toScreenCoordinates(newXYProcessingCoordinates, previousProcessingFrame.width, previousProcessingFrame.height), changeInt));
      } else {
        motionImage.pixels[loc] = transparentBlack;
        motionImageAlphaChannel.pixels[loc] = transparentBlack;
      }
    }
  }
  motionImage.updatePixels();
  motionImageAlphaChannel.updatePixels();

  percentMotion = (float)numberOfMotionPixels / (float)totalPixels;
  
  // https://www.wolframalpha.com/input/?i=plot+x%2F(x%2Ba)+where+x+%3D+0+to+1,a+%3D+0.1
  amountOfMotion = percentMotion / (percentMotion + 0.1);

  top100MotionPixels = motionPixels.toArray();

  movementDetected = newMotion;
  PVector motionPixel = new PVector(newX, newY);
  maxMotionLocation = toScreenCoordinates(motionPixel, previousProcessingFrame.width, previousProcessingFrame.height);
}

float toScreenX(float x, float srcMaxX) {
  return constrain((float) x * (float) width / srcMaxX, 0, width);
}

float toScreenY(float y, float srcMaxY) {
  return constrain((float) y * (float) height / srcMaxY, 0, height);
}

PVector toScreenCoordinates(PVector pv, int srcWidth, int srcHeight) {
  float newX = constrain(round((float) pv.x * (float) width / (float) (srcWidth)), 0, width);
  float newY = constrain(round((float) pv.y * (float) height / (float) (srcHeight)), 0, height);

  return new PVector(newX, newY);
}

class MotionPixel implements Comparable<MotionPixel> {
  PVector location;
  int changeAmount;

  MotionPixel(PVector location, int changeAmount) {
    this.location = location;
    this.changeAmount = changeAmount;
  }

  int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + changeAmount;
    result = prime * result + ((location == null) ? 0 : location.hashCode());
    return result;
  }

  boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    MotionPixel other = (MotionPixel) obj;
    if (changeAmount != other.changeAmount)
      return false;
    if (location == null) {
      if (other.location != null)
        return false;
    } else if (!location.equals(other.location))
      return false;
    return true;
  }

  int compareTo(MotionPixel o) {
    return Integer.valueOf(o.changeAmount).compareTo(changeAmount);
  }
}

class MotionPixels {
  PriorityQueue<MotionPixel> queue = new PriorityQueue<MotionPixel>();

  void add(MotionPixel motionPixel) {
    queue.add(motionPixel);
    if (queue.size() > 100) {
      queue.remove();
    }
  }

  MotionPixel[] toArray() {
    return queue.toArray(new MotionPixel[queue.size()]);
  }
}