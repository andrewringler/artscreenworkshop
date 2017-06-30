/* MovementDetected
 * 
 * displays a message when movement is detected
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

  /* the movementDetected variable is true whenever there is motion
   * false otherwise, you could also use it with a timer */
  if (movementDetected) {
    textAlign(CENTER, CENTER);
    noStroke();
    fill(255);
    textSize(72);
    text("I See You!", width / 2, height / 2);
  }
}