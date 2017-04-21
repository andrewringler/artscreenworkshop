void setup() {
  size(300,300);
  frameRate(1); //change frame-rate of draw to 1x per second
  // the default frame rate is 60 frames per second if we
  // don't change it
}

void draw() {
  // draw a circle in a random location
  ellipse(random(0,300),random(0,300),200,200);
}
 



