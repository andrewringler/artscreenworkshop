/*
 * Be Still 
 * by Kyle Keane
 */

import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
float t = 0;
float where = 0;

ArtScreen artScreen;

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“Be Still” 2017", "by Kyle Keane", "Meditation", color(255), color(0, 210));
}

void draw() {
  imageMode(CENTER);
  background(100);
  
  performMotionDetection();
  
  if (artScreen.captureFrameNumber < 0) {
    return;
  }

  t = t + PI/16 % 2 * PI; 

  for (int i = 1; i < 25; i = i + 1) {
    tint(255, 100);
    float motion = constrain(map(totalMoved, 0, 0.25*width*height, 0, 2), 0, 2);
    image(artScreen.captureFrame, 
      width/2, height/2, 
      width + 20*(i^2)*cos(motion*t), 
      height + 20*(i^2)*sin(motion*t));
  }
}