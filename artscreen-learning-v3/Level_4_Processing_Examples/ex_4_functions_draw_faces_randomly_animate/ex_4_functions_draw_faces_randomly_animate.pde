/**
 * Show how functions work
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
  
  /* here we "call" the function
   * AKA we tell it to run
   */
  drawFace();
  
  drawFace(); // run again
  drawFace(); // run again, now we have 3 faces
}

/* drawFace
 * this is a function that draws a small face
 * at a random location
 *
 * functions can have any name (letters and numbers) but
 * the first letter of a function name must be a letter
 */
void drawFace() {
  /* choose a random location to draw our face */
  float x = random(40,760);
  float y = random(40,110);
  
  noStroke();
  ellipseMode(CORNER);
  
  // draw the face
  fill(0);
  ellipse(x,y,40,40);
  
  // draw the eyes
  // we use x+ and y+ to make
  // sure our eyes move with our face
  fill(#FFEF34);
  ellipse(x+8,y+10,10,10);
  ellipse(x+22,y+10,10,10);
}


