void setup() {
  size(500, 500);

  fill(255, 0, 0, 20);
  noStroke();

  background(255);
}

void draw() {
  /* draw 3 rectangles, pick a size between 1-50 pixels
   * each time draw is called by Processing */
  float size = random(1,80);
  rect(mouseX, mouseY, size, size);
  rect(mouseX-1, mouseY-1, size, size);
  rect(mouseX+1, mouseY+1, size, size);
}

