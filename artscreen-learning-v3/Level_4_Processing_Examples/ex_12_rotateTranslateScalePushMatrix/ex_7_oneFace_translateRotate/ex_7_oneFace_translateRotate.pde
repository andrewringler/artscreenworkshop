void setup() {
  size(600, 600);
  background(0);
}

void draw() {
  background(0);

  /* first translate our coordinate system to the mouse position,
   * then draw the face at 0, 0 */
  translate(mouseX, mouseY);
  rotate((float)mouseX/width * TWO_PI);
  drawFace(75);
}

/* draw a face at 0, 0 */
void drawFace(int size) {
  ellipseMode(CENTER);

  // head
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(0, 0, size, size);

  // eyes
  noStroke();
  fill(0, 200, 0);
  ellipse(-size*0.24, -size*0.1, size*.1, size*.1); // left
  ellipse(size*0.24, -size*0.1, size*.1, size*.1); // right

  // nose
  stroke(0);
  fill(255);
  ellipse(0, size*.01, size*.09, size*.091);

  // mouth
  ellipse(0, size*0.3, size*.2, size*.2);
}