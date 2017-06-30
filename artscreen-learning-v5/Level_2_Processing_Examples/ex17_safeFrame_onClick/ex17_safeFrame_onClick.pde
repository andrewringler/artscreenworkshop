void setup() {
  size(300,300);
}

void draw() {
  // draw a circle in a random location
  ellipse(random(0,300),random(0,300),200,200);
}

/* When a mouse button is pressed inside
 * the Sketch window, save the current view
 * to a new image file */
void mouseClicked() {
  // see https://processing.org/reference/saveFrame_.html
  // and https://processing.org/reference/mouseClicked_.html
  saveFrame("screenshots/######.jpg"); // you may also you .png, .tif, .tga
}
  
 