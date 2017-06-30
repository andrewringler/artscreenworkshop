void setup() {
  size(500, 500);
  background(#D9ECFA);
  stroke(232,23,187);
  strokeWeight(10);
  frameRate(1);
}

void draw() {
  line(mouseX, mouseY, pmouseX, pmouseY);
}