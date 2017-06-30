/* MotionImage
 *
 * just draws the motion image to the screen
 */
ArtScreen artScreen;
Capture cam; // will be initialized by ArtScreen
boolean cameraReady = false;
PImage mirrorCam; // a mirrored version of cam

void setup() {
  size(1920, 1080, P2D);

  // Edit your title and name below  
  artScreen = new ArtScreen(this, "“My Artwork” 2017", "by Andrew R.", "Thanks to Others", color(0, 0, 0), color(255, 255, 255));
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
  
  // clear the background
  background(0);

  // draw the motion image to the screen
  // this image is the same as the webcam except each pixel
  // is set to transparent if there is no motion
  image(motionImage, 0, 0, width, height);
}