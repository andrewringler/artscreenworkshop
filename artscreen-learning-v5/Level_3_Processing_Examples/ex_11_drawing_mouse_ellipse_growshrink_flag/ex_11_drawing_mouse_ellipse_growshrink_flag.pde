/* this sketch draws an ellipse under the mouse position
 * the size of the ellipse will grow over time
 * and then shrink. we will use a variable to keep track
 * of whether we should be growing or shrinking
 */

/* growing: we start off growing
 * this variable is often called a "mode"
 * or "flag"
 */
boolean growing = true;
/* keep track of speed in a float
 * so that we can fine tune our shrink speed
 * change this value see what happens
 */
float speed = 2.4;
float ellipseSize = 10; /* current size of the ellipse */

void setup() {
  size(500, 500);
  background(#D9ECFA);
  fill(#D2F20A, 50);
  stroke(232, 23, 187, 20);
  strokeWeight(2);
}

void draw() {
  ellipse(mouseX, mouseY, ellipseSize, ellipseSize);
  
  /* update ellipse size for the next frame */
  if (growing) {
    ellipseSize += speed;
    //ellipseSize = ellipseSize + speed;
  } else {
    ellipseSize -= speed;
  }
  
  /* change our growing mode if need be */
  if(ellipseSize >= 70){
    growing = false; /* too big, start shrinking */
  }
  if(ellipseSize <= 10){
    growing = true; /* too small, start growing again */
  }
}