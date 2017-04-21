int x = 0;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255);
  ellipse(x,50,20,20);
  x = x + 1;
  
  //conditional
  if(x > 200){
    // when the circle gets to the 200th
    // pixel we reset his x value to 0
    // thus sending him back to the start
    x = 0;
  }
}
