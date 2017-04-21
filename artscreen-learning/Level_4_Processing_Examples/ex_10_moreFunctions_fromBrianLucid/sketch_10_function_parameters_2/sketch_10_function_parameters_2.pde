// setup is run once, when the sketch is launched
void setup() {
  size(600, 600);  
  colorMode(HSB, 100);
  background(50, 20, 50);
  fill(60,60,60);
}

// draw is run over and over again
void draw() {
  blackRect(20, 20, 50, 50);
}

// this function extends Processing with a function that creates black boxes. 
void blackRect(int boxx, int boxy, int boxwidth, int boxheight) {
  noStroke();
  fill(0, 0, 0);
  rect(boxx, boxy, boxwidth, boxheight);
}
