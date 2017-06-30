/* Template
 * 
 * basic blank template to get your started programming for the Art Screen
 * everything in this template is required, so don't delete anything
 * just add things :)
 */
ArtScreen artScreen;
Capture cam; // typically you should use mirrorCam below 
boolean cameraReady = false;
PImage mirrorCam; // a mirrored version of cam

void setup() {
  size(1920, 1080, P2D);

  // Edit your title and name below  
  artScreen = new ArtScreen(this, "“My Artwork” 2017", "by Andrew R.", "Thanks to Others", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
  if (!cameraReady) {
    return; // don't start drawing until our webcam is ready
  }    

  //
  //
  //
  //   Add your own Draw code here
  //   you can delete these comments
  //
  //
  //
}



// receives the next frame of video from the webcam
void captureEvent(Capture c) {
  c.read();

  generateMirroredImage(c);
  performMotionDetection(mirrorCam);

  //
  //    Place your own custom video processing code
  //    here, if you have any
  //    you can delete these comments
  //

  cameraReady = true;
}