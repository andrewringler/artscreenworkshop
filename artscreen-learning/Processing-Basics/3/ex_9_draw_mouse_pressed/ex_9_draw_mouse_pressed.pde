color backgroundColor = color(240, 136, 233);

void setup() {
  size(400, 400);
  background(backgroundColor);
  noStroke();
  fill(182, 220, 250, 80);
}

void draw() {
  if (mousePressed) {
    /* when the mouse is pressed draw a bigger circle */
    ellipse(mouseX, mouseY, 45, 45);
  } else {
    ellipse(mouseX, mouseY, 20, 20);
  }
}

