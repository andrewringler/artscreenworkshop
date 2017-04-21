/**
 * Draw some eyes
 * a function with parameters
 *
 * each eye is drawn differently
 * https://processing.org/examples/functions.html
 */
void setup() {
  size(800, 150);
  frameRate(1);
} 

void draw() {
  background(0); // set background to black
  
  /* here we "call" the drawEye function
   * AKA we tell it to run. We pass in required "arguments"
   * to customize how it runs
   */
  drawEye(100, 30, 50); // draw an eye
  drawEye(120, 15, 15); // draw another eye
  drawEye(200, 15, 80); // draw another eye
  drawEye(220, 15, 5); // draw another eye
  drawEye(300, 80, 100); // draw another eye
  
  // the Moving eye!
  drawEye(random(0,300), random(0,100), random(20, 200)); // draw another eye

}




/* drawEye
 * this is a function that draws an eye, it takes
 * in several parameters to customize where it is drawn
 * and how it looks. I function can have 0 or more parameters
 *
 * x: x-location of the eye
 * y: y-location of the eye
 * eyeWidth: the width of the eye
 */
void drawEye(float x, float y, float eyeWidth) {
  noStroke();
  ellipseMode(CENTER);
  /* the height of the eye will be half the width */
  float eyeHeight = eyeWidth*0.5;  
  float pupilSize = eyeWidth*0.2; // pupil is 20% the size of the eye  

  // Sclera, whites of the eye
  fill(255);
  ellipse(x, y, eyeWidth, eyeHeight); // draw an ovoid eye

  // iris  
  fill(#EA68D3);
  ellipse(x, y, eyeHeight, eyeHeight);
  
  // pupil
  fill(0);
  ellipse(x, y, pupilSize, pupilSize);
}


