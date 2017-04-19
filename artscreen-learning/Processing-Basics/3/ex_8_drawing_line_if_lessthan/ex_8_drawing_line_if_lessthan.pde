void setup() {
  size(500, 500);
  background(255);
  stroke(232, 23, 187);
}

void draw() {
  /* mouse X position must be less than 250
   * AKA on the left side
   * to allow us to draw a line */
  if (mouseX < 250) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

