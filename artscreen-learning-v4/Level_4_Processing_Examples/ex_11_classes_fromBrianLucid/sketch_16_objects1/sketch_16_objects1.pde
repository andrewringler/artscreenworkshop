// in this sketch, we are using functions to separate the different things that this "box" does

color c = color(0);
float x = 0;
float y = 100;
float speed = 1;

void setup() {
  size(600,600);
}

void draw() {
  background(255);
  move();
  display();
}

void move() {
  x = x + speed;
  if (x > width) {
    x = 0;
  }
}

void display() {
  fill(c);
  rect(x,y,30,10,5); // note the corner radius in the rect
}
