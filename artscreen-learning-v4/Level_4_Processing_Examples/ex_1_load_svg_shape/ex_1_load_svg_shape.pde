/* create basic shapes
 * for more details see
 * https://processing.org/reference/createShape_.html
 * 
 * we also included the original Illustrator file in 
 * an assets folder, which is completely optional
 * but a good practice to keep them with your code */ 
PShape blob;

void setup() {
  // use the P3D rendered which supports shapes, https://processing.org/reference/size_.html
  size(500, 500, P3D);

  /* The file "blob.svg" must be in the data folder
   * of the current sketch to load successfully
   * this was created from an Illustrator file blob.ai
   * then clicking Save as...  SVG from Illustrator
   */
  blob = loadShape("blob.svg");
}

void draw() {
  background(255);

  /* draw shape in the center of the screen
   * and stretch to a new width / heigh of 200x200 */
  shapeMode(CENTER);
  shape(blob, width/2, height/2, 400, 400);
}
