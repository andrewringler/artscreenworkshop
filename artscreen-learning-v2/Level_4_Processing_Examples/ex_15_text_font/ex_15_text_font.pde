PFont luminari;

void setup() {
  size(400, 400);
  background(0);

  /* load the font in the the luminari variable
   * The font must be located in the sketch's 
   * "data" directory to load successfully
   * to create a font for use in Processing
   * choose Tools > Create Font… */
  luminari = loadFont("Luminari-Regular-48.vlw");

  /* set current font to luminari and set his size to 48 */
  textFont(luminari, 48); 
  textAlign(CENTER);
  text("Hello", 200, 200); // draw the text
}

