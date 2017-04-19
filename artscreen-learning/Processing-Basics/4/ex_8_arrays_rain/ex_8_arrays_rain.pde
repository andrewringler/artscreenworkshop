/**
 * Rain dots using arrays
 *
 * a good long explanation of arrays here
 * https://processing.org/reference/Array.html
 */

int rainDropSize = 10;
int numberOfRainDrops = 1000;
/* create an array of size 100 to store all the X
 * values of our rain drops, and another to store our
 * Y values
 *
 * the "new" command "initializes" an empty array
 */
float x[] = new float[numberOfRainDrops];
float y[] = new float[numberOfRainDrops];

void setup() { // setup has a return type of "void" meaning it doesn't return anything
  size(800, 800);
  noStroke();
  fill(#EDF2FF, 200);

  /* fill in array values so our raindrops start at the top of the screen */
  for (int i=0; i<x.length; i++) {
    // arrays are index from 0 to array size
    // so an array of size 2, has indices 0,1

    // set the i-th value of x within the array to a random point
    // between 0 and the screen width, so the raindrop will start anywhere
    // in the x direction 
    x[i] = random(0, width);   
    y[i] = random(0, height);
  }
}

void draw() {  // draw has a return type of "void" meaning it doesn't return anything
  background(0);

  for (int i=0; i<x.length; i++) {
    /* draw all our raindrops */
    float xvalue = x[i]; // set xvalue to be the value of x[i], or the i-th index of the x array
    float yvalue = y[i]; // set yvalue to be the value of y[i], or the i-th index of the y array
    ellipse(xvalue, yvalue, rainDropSize, rainDropSize);

    /* move our raindrop, down for the next time we draw */
    y[i] = y[i] + 1.1;

    /* add a little bit of jitter for the wind
     * some of them will blow in the wind */
    if (random(0, 1) < 0.1) {
      x[i] = x[i] + random(-0.3, 0.3);
      y[i] = y[i] + random(-0.1, 0.1);
    }

    /* if this raindrop has fallen off the bottom of the page
     * start it over at the top */
    if (y[i] > height) {
      y[i] = 0;
    }
  }
}

