/*
 * Faces
 * by Andrew Ringler
 * 
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;
ArtScreen artScreen;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Faces”, 2017", "by Andrew Ringler", "", color(255), color(0, 0));
}

void draw() {
  background(0);

  /* Draw an ellipse every place we detect a face */
  noStroke();
  fill(255);
  for (Face face : artScreen.faces) {
    ellipse(face.location.x, face.location.y, face.width, face.height);
  }
}