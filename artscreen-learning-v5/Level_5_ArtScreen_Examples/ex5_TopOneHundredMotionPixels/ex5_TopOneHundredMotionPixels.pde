/* TopOneHundredMotionPixels
 * 
 * displays a circle at locations where we see motion
 */
ArtScreen artScreen;
Capture cam; // will be initialized by ArtScreen
boolean cameraReady = false;
PImage mirrorCam; // a mirrored version of cam

void setup() {
  size(1920, 1080, P2D);

  // Edit your title and name below  
  artScreen = new ArtScreen(this, "“My Artwork” 2017", "by Andrew R.", "Thanks to Others", color(0, 0, 0), color(255, 255, 255));
  background(0);
}

void draw() {
  if (cam.available()) {
    cam.read();
    generateMirroredImage(cam);
    performMotionDetection(mirrorCam);
  }
  if (!cameraReady) {
    return; // don't start drawing until our webcam is ready
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
      fill(lerpColor(color(242, 250, 141), color(250, 15, 3), motionPixel.changeAmount / 255f));
      ellipse(motionPixel.location.x, motionPixel.location.y, ellipseSize, ellipseSize);
    }
  }
}