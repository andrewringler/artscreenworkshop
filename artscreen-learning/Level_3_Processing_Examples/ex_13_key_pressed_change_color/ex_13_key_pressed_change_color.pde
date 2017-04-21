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
  if (key == '0') {
    // back to original color
    fill(182, 220, 250, 80);
  }   
  if (key == '1') {
    fill(#312381, 60);
  }   
  if (key == '2') {
    fill(#1E5541, 40);
  }
  if (key == '3') {
    fill(#1E3C55, 20);
  }
  if (key == '4') {
    fill(#DD3AF0, 10);
  }
  if (key == '5') {
    fill(#4B462A, 5);
  }
  if (key == '6') {
    fill(#D8601A, 2);
  }
}

