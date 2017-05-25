int x = 50;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255);
  ellipse(x,50,20,20);
  x = x + 1;
  
  ellipse(20,20,50,50);
  ellipse(50,50,50,50);
}
