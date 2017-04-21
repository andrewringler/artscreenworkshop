void setup() {
  size(600, 600);
  background(0);

  // draw a grid of faces
  for (int i=100; i<width; i+=200) {
    for (int j=100; j<height; j+=200) {
      drawFace(i, j, 75);
    }
  }
}

void drawFace(int x, int y, int size) {
  ellipseMode(CENTER);
  
  // head
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(x, y, size, size);

  // eyes
  ellipse(x-size*0.24, y-size*0.1, size*.1, size*.1); // left
  ellipse(x+size*0.24, y-size*0.1, size*.1, size*.1); // right

  // nose
  ellipse(x, y+size*.01, size*.09, size*.091);

  // mouth
  ellipse(x, y+size*0.3, size*.2, size*.2);
}