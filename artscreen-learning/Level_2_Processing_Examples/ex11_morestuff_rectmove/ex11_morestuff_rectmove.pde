int x1 = 50;
int x2 = 50;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255);
  ellipse(x1,50,20,20);
  x1 = x1 + 1;

  rect(x2,70,20,20);
  x2 = x2 + 2; //rect will move faster
  
  // circles will never move
  ellipse(20,20,50,50);
  ellipse(50,50,50,50);
}
 