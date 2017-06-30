// setup is run once, when the sketch is launched
void setup() {
  size(600, 600);  
  colorMode(HSB, 100);
  background(50, 20, 50);
  fill(60,60,60);
}

// draw is run over and over again
void draw() {
  createBox();  // calls the function named createBox
  createThreeBoxes(220);      // this function call now passes a parameter
}

// a custom function I have written
void createBox() {
   rect(50,50,100,100);
}

// this function now reqires a parameter.. some data to work with
void createThreeBoxes(int startPoint) {
  rect(startPoint, 50, 100, 100);
  rect(startPoint + 20, 70, 100, 100);
  rect(startPoint + 40, 90, 100, 100);
}

// with function parameters, your functions can become factories

