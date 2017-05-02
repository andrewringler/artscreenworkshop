/*
 * Max Motion:
 *
 * displays a shape at the location on the screen of the maximal motion detected
 * maxMotionLocation is quite sensitive and jumps around alot, so we typically want to 
 * smooth his motion out
 *
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "3rd line", color(255), color(0, 1));
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 5) {
    return; // wait until motion has stabilized
  }

  // clear the background with a slight transparency to smooth out
  // the sometimes radical movement of maxMotionLocation
  background(0, 25);

  // max motion is only defined when there is movement
  // so we need to check for movement first
  if (movementDetected) {
    fill(90, 210, 242, 150);
    noStroke();

    // maxMotionLocation is a PVector, but we just use the PVector for his location x,y
    ellipse(maxMotionLocation.x, maxMotionLocation.y, 30, 30);
  }
}