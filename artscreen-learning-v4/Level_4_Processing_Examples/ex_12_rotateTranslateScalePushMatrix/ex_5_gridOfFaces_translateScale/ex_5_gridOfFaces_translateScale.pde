/* draw a grid of faces
 * use the mouse position to scale the face size
*/
void setup() {
  size(600, 600);
  background(0);
}

void draw() {
  background(0);

  /* first translate our coordinate system to the mouse position,
   * then draw the face at 0, 0 */
  for (int i=100; i<width; i+=200) {
    for (int j=100; j<height; j+=200) {
      pushMatrix(); // save the old coordinate system
      translate(i, j);
      drawFace(75);
      popMatrix(); // restore the old coordinate system
    }
  }
}

/* draw a face at 0, 0 */
void drawFace(int size) {
  /* use the mouse x position to change size of faces */
  float scaleAmount = 1.0 + (float)mouseX/width*3.0;
  scale(scaleAmount);

  ellipseMode(CENTER);

  // head
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(0, 0, size, size);

  // eyes
  ellipse(-size*0.24, -size*0.1, size*.1, size*.1); // left
  ellipse(size*0.24, -size*0.1, size*.1, size*.1); // right

  // nose
  ellipse(0, size*.01, size*.09, size*.091);

  // mouth
  ellipse(0, size*0.3, size*.2, size*.2);
}