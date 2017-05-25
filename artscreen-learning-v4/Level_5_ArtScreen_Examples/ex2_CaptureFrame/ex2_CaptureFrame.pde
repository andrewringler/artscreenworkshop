/*
 * artScreen.captureFrame:
 * displays the currently captured frame of video
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

  // if we don't have at least one frame of video then 'return'
  // IE quit this draw loop and wait for draw to be called again
  if (artScreen.captureFrameNumber < 0) {
    return;
  }

  // we don't need to clear the background because we 
  // are filling the screen with an entirely opaque image
  // if we make it more transparent with filters or tints, then we could clear the background
  //background(0);

  // draw the entire capture frame, to the screen, stretch to fill the entire screen
  image(artScreen.captureFrame, 0, 0, width, height);
  filter(THRESHOLD, 0.4);
  filter(BLUR, 1);
}