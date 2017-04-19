/*
 * Title
 * by Yourname
 * 
 * Credits:
 * anyone you took code from and need to credit
 * and the URLs of that code
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "Title", "by Your Name", "Credits and other optional smaller third line", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
  /* since we are rear-projecting our image will be
   * mirrored, so we want to flip it, so text reads correctly
   * and so that user's motion is as expected */
  scale(-1, 1);
  translate(-width, 0);

  background(100);

  textSize(40);
  textAlign(CENTER, CENTER);

  text("Middle", width/2, height/2);
  text("Left", 160, height/2);
  text("Right", width - 160, height/2);
  text("Top Left", 160, 160);
  text("Top Right", width - 160, 160);
  text("Bottom Left", 160, height - 160);
  text("Bottom Right", width - 160, height - 160);
}