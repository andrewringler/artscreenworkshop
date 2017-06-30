
class Car {         // define class name
  
  float xpos = 20;
  float ypos = 20;
  float xspeed = 2;


  // The Constructor is defined with arguments.
  // constructor is called when the object is created
  Car(int tempx, int tempy) {             // constructor now requires two arguments
   
   println("a car has been created");
   
   xpos = tempx;    // put local passed values into class variables
   ypos = tempy;
  }

  void display() {
    stroke(0);
    fill(30);
    rectMode(CENTER);
    rect(xpos,ypos,20,10,5);    // draws a rectangle
  }

  void drive() {              // moves box forward
    xpos = xpos + xspeed;
    if (xpos > width) {
      xpos = 0;
    }
  }
}
