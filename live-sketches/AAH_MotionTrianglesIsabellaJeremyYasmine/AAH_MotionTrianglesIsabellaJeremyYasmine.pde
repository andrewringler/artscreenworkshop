/*
 * Motion Triangles
 * by Andrew Ringler
 * 
 * Credits:
 * None
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "Void Triangles”, 2017", "anonymoose", "???", color(255), color(0, 0, 0, 1), 100);
}
int x = 0;
int y = 0;
void draw() {
  // replace background with transparency, to keep faded trails
  y+=1;
  fill(y%235, y%51, y%154);
  rect(0, 0, width, height);
  x += 1;
  // iterate over motion pixels, grab at most 10
  // or less if less are available
  fill(x%255, x%174, x%100, 120);
  noStroke();
  for (int i=0; i<100 && i<artScreen.top100MotionPixels.length; i++) {
    MotionPixel motionPixel = artScreen.top100MotionPixels[i];
    triangle(
      motionPixel.location.x, motionPixel.location.y, // point-1 
      motionPixel.location.x + motionPixel.changeAmount /2.0, motionPixel.location.y + motionPixel.changeAmount, // point-2
      motionPixel.location.x + motionPixel.changeAmount, motionPixel.location.y // point-3 
      );
  }
}