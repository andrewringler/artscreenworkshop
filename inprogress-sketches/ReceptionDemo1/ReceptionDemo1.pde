void setup() {
  size(600, 400);
}

void draw() {
  background(136, 24, 106); // clear background
  
  // set stroke color for all shapes
  strokeWeight(7);
  stroke(127, 235, 239);

  // draw a rectangle
  fill(239, 118, 76);
  rect(74, 216, 81, 141);

  // draw an ellipse
  fill(88, 251, 69);
  ellipse(86, 83, 74, 106);

  // draw a triangle
  fill(210, 83, 221);
  triangle(304, 252, 374, 110, 233, 172);
}