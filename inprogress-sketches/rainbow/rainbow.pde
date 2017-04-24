void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100, 1);
}

void draw() {
  background(0);
  noStroke();

  //roygbv
  fill(360, 100, 100, 1); // red
  arc(50, 50, 80, 80, 0, PI+QUARTER_PI, CHORD);

  fill(24, 100, 100, 1); // orange
  arc(52, 52, 75, 75, 0, PI+QUARTER_PI, CHORD);
}