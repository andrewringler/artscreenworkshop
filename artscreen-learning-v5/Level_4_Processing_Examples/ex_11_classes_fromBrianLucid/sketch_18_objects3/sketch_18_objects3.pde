Car myCar1;
Car myCar2;

void setup() {
  size(200,200);
  myCar1 = new Car(40,40); 
  myCar2 = new Car(80, 80);
}

void draw() {
  background(255);
  myCar1.drive();
  myCar1.display();
  myCar2.drive();
  myCar2.display();
  
  println(myCar1.xpos);
}





