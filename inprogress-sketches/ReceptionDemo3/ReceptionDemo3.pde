import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;

ArtScreen artScreen;

void setup() {
  size(600, 400, P2D);
  artScreen = new ArtScreen(this, "“Demo” 2017", "by You", "", color(255), color(0, 1), false /* don't mirror output */);
}

void draw() {
  performMotionDetection();

  // clear the sketch by drawing a semi-tranparent rectangle
  noStroke();
  fill(94, 50, 109, 25);
  rect(0, 0, width, height);

  // motion pixels exist wherever there is motion
  // connect motion pixels with lines
  for (MotionPixel mp1 : top100MotionPixels) {
    for (MotionPixel mp2 : top100MotionPixels) {
      if (random(100) > 98.5) {       // only draw some lines
        strokeWeight(1);              //  line thickness
        stroke(120, 217, 218, 20);    // line color 
        line(mp1.location.x, mp1.location.y, mp2.location.x, mp2.location.y);
      }
    }
  }
}