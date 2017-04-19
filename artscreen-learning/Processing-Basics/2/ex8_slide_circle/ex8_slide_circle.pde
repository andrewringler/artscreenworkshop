/* circle slides across the screen
 * notice how the trail of previous
 * circles stays on the screen
 */
int x = 50;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  ellipse(x,50,20,20);
  x = x + 1;
}
 



