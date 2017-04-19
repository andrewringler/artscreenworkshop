/**
 * A simple helper function with a return value
 *
 * https://processing.org/reference/return.html
 */

/* x,y location of the square
 * and size of the square */
int x = 400;
int y = 400;
int size = 30;

void setup() { // setup has a return type of "void" meaning it doesn't return anything
  size(800, 800);
  background(255);
  noStroke();
}

void draw() {  // draw has a return type of "void" meaning it doesn't return anything
  boolean answer = isInsideSquare();
  
  if (answer == true) {
    fill(#F519C2);
  } else {
    fill(0);
  }

  rect(x, y, size, size);
}

/* isInsideSquare
 *
 * returns true if the mouse is inside the square
 * otherwise returns false
 *
 * isInsideSquare has a return type of "boolen"
 * which means it must return a boolean value by saying return … somewhere.
 */
boolean isInsideSquare() { 
  /* standard "is mouse inside a square calculation"
   * is mouse to the left of X coordinate, to the left of x-coord plus width of square */
  if (mouseX > x && mouseX < x+size
    && mouseY > y && mouseY < y+size) {
    return true; // this function immediately quits returning the value true
  } else {
    return false; // this function immediately quits returning the value false
  }
}

