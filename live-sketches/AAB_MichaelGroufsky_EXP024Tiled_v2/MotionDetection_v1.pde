/* ArtScreenCV (Art Screen Computer Vision)
 *
 * various functions to assist in analyzing the images
 * coming in from the webcam
 */
import java.util.PriorityQueue;

float MAX_PIXEL_CHANGE = 442; // sqrt(255^2 + 255^2 + 255^2) ~= 442
int MOTION_THRESHOLD = 80;

boolean debug = false;
boolean movementDetected = false;
PVector maxMotionLocation = new PVector(0, 0);
MotionPixel[] top100MotionPixels = new MotionPixel[] {};

PImage previousProcessingFrame; // smaller frame for image processing / previous frame
PImage processingFrame; // smaller frame for image processing
PImage motionImage;
int lastProcessedFrameNumber = -1;

void performMotionDetection() {
  // initialize empty images for the first time
  if (previousProcessingFrame == null) {
    previousProcessingFrame = createImage(artScreen.captureWidth / 4, artScreen.captureHeight / 4, RGB);
    processingFrame = createImage(artScreen.captureWidth / 4, artScreen.captureHeight / 4, RGB);
    motionImage = createImage(artScreen.captureWidth / 4, artScreen.captureHeight / 4, RGB);
  }

  // if we have not yet processed the current video frame, do so
  if (lastProcessedFrameNumber != artScreen.captureFrameNumber && artScreen.captureFrameNumber >= 0) {
    // copy capture frame to smaller image to perform processing on
    processingFrame.copy(artScreen.captureFrame, 0, 0, artScreen.captureFrame.width, artScreen.captureFrame.height, 0, 0, processingFrame.width, processingFrame.height);

    if (artScreen.captureFrameNumber > 0 /* we need at least two frames for frame differencing */) {
      detectMotion();
    }

    // copy current frame to previous for next time
    previousProcessingFrame.copy(processingFrame, 0, 0, processingFrame.width, processingFrame.height, 0, 0, previousProcessingFrame.width, previousProcessingFrame.height);

    lastProcessedFrameNumber = artScreen.captureFrameNumber;
  }
}

void detectMotion() {
  pushStyle();
  colorMode(RGB, 255);

  processingFrame.loadPixels();
  previousProcessingFrame.loadPixels();
  motionImage.loadPixels();

  MotionPixels motionPixels = new MotionPixels();

  float maxChange = 0;
  boolean newMotion = false;
  int newX = 0;
  int newY = 0;
  for (int x = 0; x < previousProcessingFrame.width; x++) {
    for (int y = 0; y < previousProcessingFrame.height; y++) {
      int loc = x + y * previousProcessingFrame.width; //1D pixel location
      int oldR = round(red(previousProcessingFrame.pixels[loc]));
      int oldG = round(green(previousProcessingFrame.pixels[loc]));
      int oldB = round(blue(previousProcessingFrame.pixels[loc]));
      int newR = round(red(processingFrame.pixels[loc]));
      int newG = round(green(processingFrame.pixels[loc]));
      int newB = round(blue(processingFrame.pixels[loc]));

      float change = dist(oldR, oldG, oldB, newR, newG, newB);
      if (change > MOTION_THRESHOLD) {
        if (change > maxChange) {
          newMotion = true;
          newX = x;
          newY = y;
        }
        byte changeB = (byte) constrain((int) (change / MAX_PIXEL_CHANGE * 255f), 0, 255);
        motionImage.pixels[loc] = color((int) changeB);
        PVector newXYProcessingCoordinates = new PVector(x, y);
        motionPixels.add(new MotionPixel(toScreenCoordinates(newXYProcessingCoordinates, previousProcessingFrame.width, previousProcessingFrame.height), changeB));
      } else {
        motionImage.pixels[loc] = color(0);
      }
    }
  }
  motionImage.updatePixels();

  top100MotionPixels = motionPixels.toArray();

  movementDetected = newMotion;
  PVector motionPixel = new PVector(newX, newY);
  maxMotionLocation = toScreenCoordinates(motionPixel, previousProcessingFrame.width, previousProcessingFrame.height);

  popStyle();
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
  byte changeAmount;

  MotionPixel(PVector location, byte changeAmount) {
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
    return Byte.valueOf(o.changeAmount).compareTo(changeAmount);
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


public void drawDebugInfo() {
  pushStyle();

  pushMatrix();
  if (sketchRenderer() == P3D) {
    camera(); // https://github.com/processing/processing/issues/2128
  } else {
    resetMatrix();
  }

  colorMode(RGB, 255);

  scale(-1, 1);
  translate(-width, 0);
  strokeWeight(2);
  rectMode(CENTER);
  fill(0);
  stroke(255);

  // draw change amount at every motion pixel
  for (MotionPixel motionPixel : top100MotionPixels) {
    float motionPixelVizHeight = map(motionPixel.changeAmount, 0, 255, 10, 100);
    rect(motionPixel.location.x, motionPixel.location.y, 3, motionPixelVizHeight);
  }

  popMatrix();
  popStyle();
}