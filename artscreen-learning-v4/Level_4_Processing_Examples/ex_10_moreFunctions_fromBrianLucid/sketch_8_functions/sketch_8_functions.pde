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
}

// a custom function I have written
void createBox() {
   rect(50,50,100,100);
}


/*
// another custom function I have written
void createThreeBoxes() {
  rect(250,50,100,100);
  rect(270,70,100,100);
  rect(290,90,100,100);
}
*/


// functions are ways for you to organize and segment your code

// note that the function we have created looks a lot like many of the processing statements
// we have used previously. These are simply built-in functions of processing.


          
