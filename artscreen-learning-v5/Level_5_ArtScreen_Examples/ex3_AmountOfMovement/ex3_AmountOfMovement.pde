/* AmountOfMovement
 * 
 * draw a circle the to scren the varies in size depending
 * on how much movement there is
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

  // draw a circle to the screen, that will be bigger
  // when there is more movement detected
  background(0);
  fill(255, 0, 0);
  ellipseMode(CENTER);
  float circleSize = amountOfMotion * 1000;
  ellipse(width/2, height/2, circleSize, circleSize);
}