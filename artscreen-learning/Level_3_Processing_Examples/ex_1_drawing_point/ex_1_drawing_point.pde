void setup() {
  size(500, 500);
  background(255);
  stroke(232,23,187);
}

void draw() {
  /* draw a pink dot at the current
   * mouse position every time draw is
   * called by Processing */
  point(mouseX, mouseY);
  println(mouseX,mouseY);
}

