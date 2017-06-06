import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;

ArtScreen artScreen;

void setup() {
  size(600, 400, P2D);
  artScreen = new ArtScreen(this, "“Demo” 2017", "by You", "", color(255), color(0, 1), false /* don't mirror output */);
}

void draw() {
  performMotionDetection();

  // the motion image not our screen resolution, so lets stretch/shrink the output
  scale((float)width / motionImage.width, (float)height / motionImage.height);

  background(123, 15, 158, 200); // set the background color

  // don't process every pixel, skip some
  int skipPixels = 5;

  // loop over all pixels in motion image and instead of drawing pixels
  // draw a shape related to that pixel
  motionImage.loadPixels();
  for (int x = 0; x < motionImage.width; x+=skipPixels) {
    for (int y = 0; y < motionImage.height; y+=skipPixels) {
      int loc = x + y * motionImage.width; //1D pixel location

      rectMode(CORNER);
      strokeWeight(1);
      stroke(107, 100, 109, 15);
      fill(motionImage.pixels[loc]); // fill the color of original pixel
      
      rect(x, y, skipPixels, skipPixels);
    }
  }
}