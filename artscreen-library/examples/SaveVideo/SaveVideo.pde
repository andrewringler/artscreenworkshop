import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;

ArtScreen artScreen;
float rotation = TWO_PI;

void setup() {
  size(1920, 1080, P2D);
  
  /* NOTE this line will:
   * create a caption, fade-in/out your sketch over 1min, init the webcam
   */
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
  translate(width/2.0, height/2.0);
  rotate(rotation);
  
  background(0);
  rectMode(CENTER);
  rect(0, 0, 300, 300);
  
  rotation = (rotation + TWO_PI/20.0) % TWO_PI;
}