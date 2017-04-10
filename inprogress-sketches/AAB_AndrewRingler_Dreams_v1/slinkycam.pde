import processing.video.*;

MotionCam[] motionCams;
int supportedCams = 0;
int captureW = 320; //1024
int captureH = 180; //768
int fps = 15;
String captureString = "size="+captureW+"x"+captureH+",fps="+fps;
float scaleX = 3.2;
float scaleY = 4.26;
PImage buffer;
boolean writeMovie = false;
int movieFrame = 0;

/*
TODO / TRY:
see: for grabbing what she calls the dominant color
pretty nice
http://www.catehuston.com/blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/

instead of pre-selecting a color for each camera, we could select the dominant color by frame
could be really nice, or keep the dominant color for several frames?
*/


void setup2() {
  background(0);
  println("Running Sketch");

  size(round(captureW*scaleX), round(captureH*scaleY));
  String[] cameraSpecs = Capture.list();

  println("Looking for cameras.");
  if (cameraSpecs.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    for (int i = 0; i < cameraSpecs.length; i++) {
      println(cameraSpecs[i]);
      if (cameraSpecs[i].endsWith(captureString)) {
        supportedCams++;
      }
    }
    motionCams = new MotionCam[supportedCams];

    int index = 0;
    for (int i = 0; i < cameraSpecs.length; i++) {
      if (cameraSpecs[i].endsWith(captureString)) {
        // The camera can be initialized directly using an 
        // element from the array returned by list():
        motionCams[index] = new MotionCam(index, new Capture(this, cameraSpecs[i]), captureW, captureH);
        index++;
      }
    }
  }
  println("Found "+supportedCams+" cameras with the resolution we want");
  if (supportedCams < 1) {
    exit();
  }

  buffer = createImage(captureW, captureH, RGB); // Create an empty image for staging the image the same size as the video
}

void draw2() {
  buffer.loadPixels();
  for (int x = 0; x < buffer.width; x ++ ) {
    for (int y = 0; y < buffer.height; y ++ ) {
      int loc = x + y*buffer.width; //1D pixel location
      int oldR = round(red(buffer.pixels[loc]));
      int oldG = round(green(buffer.pixels[loc]));
      int oldB = round(blue(buffer.pixels[loc]));
      int newR = 255;
      int newG = 255;
      int newB = 255;
      // slowly fade old colors to white
//      if (oldR != 255) {
//        newR = oldR + round((255 - oldR) / 10);
//      }
//      if (oldG != 255) {
//        newG = oldG + round((255 - oldG) / 10);
//      }
//      if (oldB != 255) {
//        newB = oldB + round((255 - oldB) / 10);
//      }
      
       // slowly fade old colors to black
      if (oldR != 0) {
        newR = oldR - round((oldR) / 10);
      }
      if (oldG != 0) {
        newG = oldG - round((oldG) / 10);
      }
      if (oldB != 0) {
        newB = oldB - round((oldB) / 10);
      }

      
      buffer.pixels[loc] = color(newR, newG, newB);
    }
  }  
  buffer.updatePixels();
  for (int i = 0; i < motionCams.length; i++) {
    MotionCam cam = motionCams[i];
    cam.updateBuffer(buffer);
  }
  image(buffer, 0, 0, captureW*scaleX, captureH*scaleY);

  if (writeMovie) {
    saveFrame("frames/"+frameCount+".png");
    movieFrame++;
  }
}

class MotionCam {
  Capture video;
  color myColor;
  int w, h;
  // motion detection via http://www.learningprocessing.com/examples/chapter-16/example-16-13/
  PImage prevFrame;
  float threshold = 50; // How different must a pixel be to be a "motion" pixel
  PImage staging;
  int i;

  MotionCam(int i, Capture camera, int w, int h) {
    this.i = i;
    this.video = camera;  
    this.w = w;
    this.h = h;
    prevFrame = createImage(w, h, RGB); // Create an empty image the same size as the video
    staging = createImage(w, h, RGB); // Create an empty image the same size as the video
    this.video.start();
    if (i==0) {
      this.myColor = color(255, 0, 0);
    } else {
      this.myColor = color(0, 255, 0);
    }
    println("setting myColor to "+myColor);
  }

  // from http://www.catehuston.com/blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/
  color getDominantColor(PImage img) {
    int hueRange = 360; 
    colorMode(HSB, (hueRange - 1));
    img.loadPixels();
    int numberOfPixels = img.pixels.length;
    int[] hues = new int[hueRange];
    float[] saturations = new float[hueRange];
    float[] brightnesses = new float[hueRange];

    for (int i = 0; i < numberOfPixels; i++) {
      int pixel = img.pixels[i];
      int hueIndex = Math.round(hue(pixel));
      float curSaturation = saturation(pixel);
      float curBrightness = brightness(pixel);
      hues[hueIndex]++;
      saturations[hueIndex] += curSaturation;
      brightnesses[hueIndex] += curBrightness;
    }

    // Find the most common hue.
    int hueCount = hues[0];
    int curHue = 0;
    for (int i = 1; i < hues.length; i++) {
       if (hues[i] > hueCount) {
        hueCount = hues[i];
        curHue = i;
      }
    }

    // Set the vars for displaying the color.
    float hue = curHue;
    float saturation = saturations[curHue] / hueCount;
    float brightness = brightnesses[curHue] / hueCount;
    
    color dominantColor = color(hue, saturation, brightness);
    
    colorMode(RGB, 255); //restore our default
    return dominantColor;
  }

  void updateBuffer(PImage buffer) {
    if (!video.available()) {
      return;
    }

    // Save previous frame for motion detection!!
    prevFrame.copy(video, 0, 0, w, h, 0, 0, w, h); // Before we read the new frame, we always save the previous frame for comparison!
    video.read();

    video.loadPixels();
    prevFrame.loadPixels();
    staging.loadPixels();
  
    color dominantColor = color(237,200,69);  
//    color dominantColor = getDominantColor(video);

    // Begin loop to walk through every pixel
    for (int x = 0; x < w; x ++ ) {
      for (int y = 0; y < h; y ++ ) {

        int loc = x + y*w;            // Step 1, what is the 1D pixel location
        color current = video.pixels[loc];      // Step 2, what is the current color
        color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color

        // Step 4, compare colors (previous vs. current)
        float r1 = red(current); 
        float g1 = green(current); 
        float b1 = blue(current);
        float r2 = red(previous); 
        float g2 = green(previous); 
        float b2 = blue(previous);
        float diff = dist(r1, g1, b1, r2, g2, b2);

        // Step 5, How different are the colors?
        // If the color at that pixel has changed, then there is motion at that pixel.
        if (diff > threshold) { 
          // If motion, display my color
//          staging.pixels[loc] = myColor;
          staging.pixels[loc] = dominantColor;
        } else {
          // If not, display white
          staging.pixels[loc] = color(255);
        }
      }
    }
    staging.updatePixels();
    for (int x = 0; x < w; x ++ ) {
      for (int y = 0; y < h; y ++ ) {
        int loc = x + y*w; //1D pixel location
        if (red(staging.pixels[loc]) == 255 && green(staging.pixels[loc]) == 255 && blue(staging.pixels[loc]) == 255) {
          // do nothing, just leave the screen to be white or fade to white over time
        }else{
          if (red(buffer.pixels[loc]) == 255 && green(buffer.pixels[loc]) == 255 && blue(buffer.pixels[loc]) == 255) {
            // buffer is blank, just replace with my color
            buffer.blend(staging, x, y, 1, 1, x, y, 1, 1, DARKEST);
          } else {
             // otherwise there is some color there, blend
             buffer.blend(staging, x, y, 1, 1, x, y, 1, 1, BLEND);
          }
        }
      }
    }
  }
}