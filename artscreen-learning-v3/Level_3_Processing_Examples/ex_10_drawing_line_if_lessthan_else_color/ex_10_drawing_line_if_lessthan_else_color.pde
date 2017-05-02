void setup() {
  size(500, 500);
  background(255);
  stroke(232, 23, 187);
}

void draw() {
  /* draw with purple lines on the left side
   * of the screen, draw with green lines on
   * the right hand side */
  if (mouseX < 250) {
    stroke(232, 23, 187);
  } else {
    stroke(27,252,13);
  }
  
  line(mouseX, mouseY, pmouseX, pmouseY);
}

