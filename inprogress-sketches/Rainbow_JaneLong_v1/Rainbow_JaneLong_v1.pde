/*
 * Title
 * by Yourname
 * 
 * Credits:
 * list anyone you took code from and need to credit
 * and the URLs of that code. If the code you copied from
 * has credits, list those too!
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", color(255), color(0, 1));

  initFlob();
  colorMode(HSB, 360, 100, 100, 1);
}

void draw() {
  videoinput.copy(artScreen.camSmallMirror, 0, 0, artScreen.camSmallMirror.width, artScreen.camSmallMirror.height, 0, 0, videoinput.width, videoinput.height);
  flobBinaryImage = flob.binarize(videoinput);
  if (flobReady) {
    flobReady = false;
    thread("updateBlobs");
  }

  rectMode(CORNER);
  fill(0, 0, 100, 0.1);
  rect(0, 0, width, height);
  flob.getImage();

  rectMode(CENTER);
  noStroke();
  for (int i = 0; i < flob.getNumTBlobs(); i++) {
    TBlob ab = flob.getTBlob(i); 
    fill(50, 100, 100, 1);
    rect(ab.cx, ab.cy, ab.dimx, ab.dimy);

    //roygbv
    //fill(360, 100, 100, 0.8);
    //rect(ab.cx, ab.cy, 200, 20);
    //fill(24, 100, 100, 0.8);
    //rect(ab.cx, ab.cy+20, 200, 20);
    //fill(60, 100, 100, 0.8);
    //rect(ab.cx, ab.cy+40, 200, 20);
    //fill(100, 100, 100, 0.8);
    //rect(ab.cx, ab.cy+60, 200, 20);
    //fill(217, 100, 100, 0.8);
    //rect(ab.cx, ab.cy+80, 200, 20);
    //fill(313, 100, 100, 0.8);
    //rect(ab.cx, ab.cy+100, 200, 20);
  }
}