void setup() {
  size(500, 500);
  background(255);
  noStroke();
  fill(232,23,187);
}

void draw() {
  /* draw a circle at the current mouse
   * position */
  ellipse(mouseX, mouseY, 45, 45);
}

