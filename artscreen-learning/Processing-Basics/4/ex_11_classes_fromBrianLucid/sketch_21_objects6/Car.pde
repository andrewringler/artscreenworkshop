
class Car {         // define class name
  
  float xpos;
  float ypos;
  float xspeed;
  color c;         


  // The Constructor is defined with arguments.
  // constructor is called when the object is created
  Car(int tempx, int tempy, int tempspeed, color tempC) { 
   
   println("a car has been created");
   
   xpos = tempx;    // put passed values into class variables
   ypos = tempy;
   xspeed = tempspeed;
   c = tempC;
  }

  void display() {
    stroke(0);
    fill(c);
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
