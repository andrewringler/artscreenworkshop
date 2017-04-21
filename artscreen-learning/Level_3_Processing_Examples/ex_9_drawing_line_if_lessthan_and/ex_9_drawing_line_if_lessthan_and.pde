void setup() {
  size(500, 500);
  background(255);
  stroke(232, 23, 187);
}

void draw() {
  /* now current mouse X position
   * and the previous mouse X position
   * must be less than 250 (on the left side)
   * to allow us to draw a line */
  if (mouseX < 250 && pmouseX < 250) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

