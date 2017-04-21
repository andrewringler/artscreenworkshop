PFont luminari;

void setup() {
  size(400, 400);
  background(0);

  /* load the font in the the luminari variable
   The font must be located in the sketch's 
   "data" directory to load successfully
   to create a font for use in Processing
   choose Tools > Create Font… */
  luminari = loadFont("Luminari-Regular-48.vlw");

  textFont(luminari, 48); 
  textAlign(CENTER);
}

void draw() {
  /* try deleting backround(0); line and 
   * what happens */
  background(0);
  text("Mouse…", mouseX, mouseY);
}

