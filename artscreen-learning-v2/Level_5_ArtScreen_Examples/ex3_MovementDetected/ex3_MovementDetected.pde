/*
 * Movment Detected:
 * displays a message while movement is detected
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
  
  /* the movementDetected variable is true whenever there is motion
   * false otherwise, you could also use it with a timer */
  if(movementDetected){
    textAlign(CENTER, CENTER);
    noStroke();
    fill(255);
    textSize(72);
    text("I See You!", width / 2, height / 2);
  }
}