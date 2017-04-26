/*
 * Top 100 Motion Pixels
 *
 * display a circle at the top 30 motion pixels
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

  background(0);

  // top100MotionPixels is only defined when there is movement
  // so we need to check for movement first
  if (movementDetected) {
    fill(90, 210, 242, 150);
    noStroke();

    /* top100MotionPixels varies in length depending on how much motion there is
     * so it is not always 100 elements long, so we should always use it with a for-loop
     * like the one below, here we loop through at most 30 MotionPixels, but we could
     * stop earlier if there is very little motion in the frame */
    for (int i=0; i<top100MotionPixels.length && i<30; i++) {
      MotionPixel motionPixel = top100MotionPixels[i];
      // motionPixel has two fields:
      // location - PVector with x,y of the location of motion
      // changeAmount - 0-255, 0 is least motion, 255 is maximal motion

      // draw an ellipse, that is more red and larger for more motion
      // and more yellow and smaller for lesser motion
      float ellipseSize = map(motionPixel.changeAmount, 0, 255, 5, 40);
      fill(lerpColor(color(242, 250, 141), color(250, 15, 3),  motionPixel.changeAmount / 255f));
      ellipse(motionPixel.location.x, motionPixel.location.y, ellipseSize, ellipseSize);
    }
  }
}