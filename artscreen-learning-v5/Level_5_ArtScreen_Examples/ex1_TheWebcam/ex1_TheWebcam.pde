/* ex1_TheWebcam
 * 
 * just draws the webcam image to the screen
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

  // just draw the contents of the webcam to our screen
  // stretch the webcam image to fill our 1920x180 canvas
  image(mirrorCam, 0, 0, width, height);
}