Car myCar1;

void setup() {
  size(200,200);
  myCar1 = new Car(); 
}

void draw() {
  background(255);
  myCar1.drive();
  myCar1.display();
}





