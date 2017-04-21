/**
 * Draw a few aliens using
 * a function with parameters
 */
void setup() {
  size(800, 150);
  frameRate(1);
} 

void draw() {
  /* set the background color white
   * background is also a function, it just
   * happens to be one that Ben Fry and Casey Reas wrote
   * not us */
  background(255);
  
  /* here we "call" the drawAlien function
   * AKA we tell it to run. We pass in required "arguments"
   * to customize how it runs
   */
  drawAlien(40, height, 50, color(#EA00D0)); // draw a pink alien
  drawAlien(80, height, 120, color(#576AE3)); // draw a tall blue alien
  drawAlien(160, height, 100, color(#67B466)); // draw another alien
  drawAlien(220, height, 32, color(#3E606A)); // draw another alien
  drawAlien(280, height, 110, color(#E903FA)); // draw another alien
  drawAlien(418, height, 87, color(#7E75B4)); // draw another alien
  
  /* draw 2 spaceships */
  drawSpaceShip(600, 20);
  drawSpaceShip(200, 22);
}




/* drawAlien
 * this is a function that draws an alien, it takes
 * in several parameters to customize where it is drawn
 * and how it looks
 *
 * x: x-location of the alien's feet
 * y: y-location of the alien't feet
 * alienHeight: height of the alien in pixels
 * alienColor: color of the alien  
 */
void drawAlien(float x, float y, float alienHeight, color alienColor) {
  /* draw the head diameter as 70% of
   * the alien's height */
  float headSize = alienHeight * 0.7;
  float eyeSize = alienHeight * 0.1;
  float bodyWidth = 5;
  
  noStroke();
  rectMode(CORNERS);

  // draw the body
  fill(alienColor); // set the color for the alien  
  rect(x-bodyWidth, y, x+bodyWidth, y-alienHeight);
  
  /* draw the face
   * subtract half the headsize to center the head
   * horizontally */
  ellipseMode(CORNER);
  ellipse(x-headSize/2, y-alienHeight, headSize, headSize);
  
  /* draw the eyes
   * we use x+ and y+ to make
   * sure our eyes move with our face
   */
  fill(255);
  ellipseMode(CENTER);
  float eyeHeight = y-alienHeight+headSize/2-3; //slightly above the middle of the face
  ellipse(x+eyeSize, eyeHeight, eyeSize, eyeSize);
  ellipse(x-eyeSize, eyeHeight, eyeSize, eyeSize);
  
  /* draw 2 feet */
  rectMode(CORNER);
  fill(alienColor, 150); // draw feet slightyl lighter than body
  rect(x-10,y-4,8,4); // left foot
  rect(x+2,y-4,8,4); // right foot
}




/* drawSpaceShip
 * draw a spaceship for the alien
 * 
 * x: x location of spaceship
 * y: y location of spaceship
 */
void drawSpaceShip(float x, float y) {
  // draw spaceship body
  strokeWeight(3);
  stroke(100);
  fill(20);
  ellipse(x, y, 200, 20);  
}
