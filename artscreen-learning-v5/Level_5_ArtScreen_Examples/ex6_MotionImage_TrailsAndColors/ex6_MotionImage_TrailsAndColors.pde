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
color randomColor;

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“Motion Image Trails & Colors” 2017", "by Your Name", "3rd line", color(0), color(255, 1));

  chooseNewRandomColor();
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

  // clear the background, but with a high opacity so we leave motion trails
  background(255, 20);

  // update the random color we use to draw our tint, every 10th frame
  if (frameCount % 10 == 0) {
    chooseNewRandomColor();
  }

  // tint affects how things are drawn to the screen after we set the tint
  // https://processing.org/reference/tint_.html
  tint(randomColor);

  // draw the motion image, to the screen, stretch to fill the entire screen
  image(motionImage, 0, 0, width, height);
}

void chooseNewRandomColor() {
  randomColor = color(random(0, 200), random(0, 200), random(0, 200), random(100, 230));
}