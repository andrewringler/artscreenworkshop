import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
float r = 0;

void setup() {
  size(1920, 1080, P3D);

  /* NOTE this line will:
   * create a caption, fade-in/out your sketch over 1min, init the webcam, save a screenshot at 30seconds
   */
  artScreen = new ArtScreen(this, "“Motion 001” 2017", "by Andrew Ringler & David Gil", "", color(255), color(0, 0, 0, 1));
}

void draw() {
  // KEEP required for simple motion detection: movementDetected, maxMotionLocation, top100MotionPixels etc…
  performMotionDetection();
  
  if(lastProcessedFrameNumber < 4){
    // wait for motion to stabilize
    return;
  }

  pushMatrix();
  resetMatrix();
  fill(0, 0, 0, 15);
  rect(0, 0, width, height);  
  popMatrix();

  rotate(r);

  strokeWeight(1 + amountOfMotion*20);

  stroke(242); // no motion color
  if (amountOfMotion > 0.6) {
    stroke(255, 0, 0);
  } else if (amountOfMotion > 0.4) {
    stroke(8, 74, 252);
  } else if (amountOfMotion > 0.2) {
    stroke(255, 255, 0);
  }

  line(-5000, height/3, width + 5000, height/3);  
  line(width * (2.0/3.0), -5000, width * (2.0/3.0), height + 5000);

  // update r, to rotate
  r = r + 0.1;
}