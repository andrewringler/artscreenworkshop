void setup() {
  size(500, 500);
  noStroke();
  background(#FFEDF3);
}

void draw() {
  fill(#FC57DE, 5);
  rect(mouseX, mouseY, 40, 40);
  
  fill(#FC5791, 1);
  rect(mouseX-20, mouseY-20, 100, 100);
  rect(mouseX+20, mouseY+20, 100, 100);
}

