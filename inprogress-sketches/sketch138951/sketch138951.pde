/*
https://www.openprocessing.org/sketch/138951
 Wavey things
 
 
 by
 Jerome
 Herr
 heavily inspired by this: http://darkbeanaday.tumblr.com/post/78337047653/some-screenshots-from-my-first-wiggly-sound
 March 9th, 2014   Creative Commons Attribution ShareAlike
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;

color col1=#409D91, col2=#FFE9B3;
int columns = 20;
float stepX, theta, ot, fc, scal=1;
float[] offSets = new float[columns];
float[] offTheta = new float[columns];
boolean save = false;

void setup() {
  size(1920, 1080, P2D); // stroke caps only work in 2d
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", col1, col2);

  stepX = width/columns;
  strokeWeight(stepX+1);
  strokeCap(ROUND);
  
  for (int i=0; i<columns; i++) {
    offSets[i]= 50; //random(20, 20);
    offTheta[i]= ot;
    ot += TWO_PI/columns;
  }

  drawWaves();
}

void draw() {
  for(MotionPixel motionPixel : artScreen.top100MotionPixels){
    int column = constrain(round((float)motionPixel.location.x / width * (columns-1)), 0, columns-1);
    offSets[column] = min(offSets[column], height - motionPixel.location.y);
  }
  
  drawWaves();
  theta -= 0.0523;
}

void drawWaves() {
  for (int i=0; i<columns; i++) {
    scal = map(sin(theta+offTheta[i]), -1, 1, 0.5, 1.5);
    float x=stepX*(i+.5);
    if (i%2==0) {
      float y = height/2 - offSets[i]*scal;
      stroke(col1);
      line(x, 0, x, y);
      stroke(col2);
      line(x, y, x, height);
    } else {
      float y = height/2 + offSets[i]*scal;
      stroke(col2);
      line(x, y, x, height); 
      stroke(col1);
      line(x, 0, x, y);
    }
  }
}