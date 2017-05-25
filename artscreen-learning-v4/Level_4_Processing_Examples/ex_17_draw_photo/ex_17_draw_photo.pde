void setup() {
  size(483, 713);
  background(0);

  // Images must be in the "data" directory to load correctly
  PImage img = loadImage("bm-bird-audobon.jpg");

  /* draw the image from the top-left corner
   * since the image is 483x713 it will take
   * up the entire canvas */
  image(img, 0, 0);
}

