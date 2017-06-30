/*
 * Motion Circles
 * by Andrew Ringler & Katrina Yan
 * 
 * Credits:
 * None
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;


int s = 30;
ArtScreen artScreen;


void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Motion Circles” 2017", "by Andrew Ringler & Katrina Yan", "", color(0, 255, 0), color(0, 1));
}

void draw() {
   noStroke();
  for (int i = 0; i <= width; i += s) {
    for (int j = 0; j <= height; j +=s) {
      fill (176,233,244);
      ellipse (i, j, s, s);
    }
  }
  
  performMotionDetection();

  if (artScreen.captureFrameNumber < 0) {
    return;
  }

  // replace background with transparency, to keep faded trails
  fill(255, 255, 255, 200);
  rect(0, 0, width, height);

  // iterate over motion pixels, grab at most 10
  // or less if less are available
  noStroke();
  for (int i=0; i<100 && i<top100MotionPixels.length; i++) {
    MotionPixel motionPixel = top100MotionPixels[i];
    
    float x0 = s*floor(motionPixel.location.x/s);
    float y0 = s*floor (motionPixel.location.y/s); 
    
    fill(255, random(0,255), random(0,255), 200);
    ellipse(x0, y0, s, s); 
   
  }
}