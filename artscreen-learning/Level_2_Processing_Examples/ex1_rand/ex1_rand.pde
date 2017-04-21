void setup() {
  size(100, 100);
}

void draw() {
  // place a 20x20 ellipse on the canvas at a random x and y location
  // between 0 and 100
  // every time you re-run the sketch the ellipse will move
  ellipse(random(0, 100), random(0, 100), 20, 20);
}