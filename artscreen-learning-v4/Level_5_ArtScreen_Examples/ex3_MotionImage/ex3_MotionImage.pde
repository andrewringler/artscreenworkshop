/*
 * motionImage:
 * displays the motion image on the screen
 * this is a PImage that shows white when there is motion
 * in front of the camera, otherwise black
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
  // this should be the first line in the draw function
  // it performs all the motion calculations
  performMotionDetection();

  /* we typically want to wait a few frames until
   * the motion has stabilized, before we draw anything */
  if (artScreen.captureFrameNumber < 5) {
    return;
  }

  // clear the background, so we don't leave motion trails
  background(0);

  // draw the motion image, to the screen, stretch to fill the entire screen
  image(motionImage, 0, 0, width, height);
}