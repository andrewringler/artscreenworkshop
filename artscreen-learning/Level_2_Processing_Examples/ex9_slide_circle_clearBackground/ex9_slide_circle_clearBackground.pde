int x = 50;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255, 200, 10);
  ellipse(x,50,20,20);
  x = x + 1;
}
 