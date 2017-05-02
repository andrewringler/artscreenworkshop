void setup() {
  size(500, 500);
  background(#D9ECFA);
  stroke(232,23,187);
  strokeWeight(10);
}

float prevX = 0;
float prevY = 0;
void draw() {
  line(mouseX, mouseY, prevX, prevY);
  
  // save off current mouse position
  // so that we have it next time
  prevX = mouseX;
  prevY = mouseY;
}

