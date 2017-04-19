void setup() {
  size(100, 100);
}

void draw() {
  // math: +-*/ ()
  ellipse(20, 20, 20, 20);
  ellipse(20, 20+20, 20, 20);
  ellipse(20, 20+40, 20, 20);

  fill(255, 0, 0);
  ellipse(40, 20, 20, 20);
  ellipse(40, 20+(1*20), 20, 20);
  ellipse(40, 20+(2*20), 20, 20);
  ellipse(40, 20+(3*20), 20, 20);

  // ellipse (x,y, width, height)
  fill(0, 255, 0);
  ellipse(60, 20, 20, 20);
  ellipse(60, 20+(1*20), 20/2, 20/2);
  ellipse(60, 20+(2*20), 20/3, 20/3);
  ellipse(60, 20+(3*20), 20/4, 20/4);
}