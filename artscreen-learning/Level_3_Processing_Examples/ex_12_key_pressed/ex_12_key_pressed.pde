void setup() {
  size(400, 400);
  background(#4B3749);
  noStroke();
  fill(182, 220, 250, 80);
}

void draw() {
  ellipse(mouseX, mouseY, 20, 20);
}

void keyPressed() {
  // if any key is pressed, clear the screen
  background(#4B3749);
}

