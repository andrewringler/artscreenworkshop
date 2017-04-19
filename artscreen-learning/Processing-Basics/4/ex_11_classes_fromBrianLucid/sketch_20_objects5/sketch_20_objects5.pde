Car myCar1;
Car myCar2;
Car myCar3;

void setup() {
  size(200,200);
  myCar1 = new Car(40,40, 2, color(255,0,0)); 
  myCar2 = new Car(80, 80, 4, color(0,255,0));
  myCar3 = new Car(20, 20, 3, color(0,0,255));
}

void draw() {
  background(255);
  myCar1.drive();
  myCar1.display();
   myCar2.drive();
  myCar2.display();
   myCar3.drive();
  myCar3.display();
}





