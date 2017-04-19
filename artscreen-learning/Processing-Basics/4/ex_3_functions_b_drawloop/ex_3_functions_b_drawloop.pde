/**
 * Show how functions work
 */
void setup() {
  size(800, 150);
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
  drawCircles();

  drawCircles(); // run again
  drawCircles(); // run again, now we have 3 circles
}



/* drawCircles
 * this is a function that draws a small circle
 * at a random location
 *
 * functions can have any name (letters and numbers) but
 * the first letter of a function name must be a letter
 */
void drawCircles() {
  /* choose a random location to draw our circle */
  float x = random(40, 760);
  float y = random(40, 110);

  noStroke();
  ellipseMode(CENTER);


  // draw outer circle
  fill(#3246BF, 20);
  ellipse(x, y, 40, 40);

  // draw inner circle
  fill(#61A8C4);
  ellipse(x, y, 20, 20);
}

