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
  artScreen = new ArtScreen(this, "“Lollipop”, 2017", "by Andrew Ringler", "", color(255), color(0, 0));
}

void draw() {
  background(0);

  /* Draw an ellipse every place we detect a face */
  for (Face face : artScreen.faces) {
    // draw circle as face
    noStroke();
    fill(255);
    ellipse(face.location.x, face.location.y, face.width, face.height);
    strokeWeight(8);
    stroke(255);
    
    // draw “body”, line from face to bottom of screen
    line(face.location.x, face.location.y, face.location.x, height);
  }
}