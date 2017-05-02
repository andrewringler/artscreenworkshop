PFont kannada;
PFont luminari;

void setup() {
  size(400, 400);
  background(0);

  /* load the fonts into two different variables
   * The font must be located in the sketch's 
   * "data" directory to load successfully
   * to create a font for use in Processing
   * choose Tools > Create Font… */
  kannada = loadFont("KannadaMN-48.vlw");
  luminari = loadFont("Luminari-Regular-48.vlw");
  
  frameRate(1);
}

void draw() {
  /* clear the background so that we have a fresh draw
   * each time */
  background(0);
  
  /* draw the text The New Yorker
   * using the kannada font to a random 
   * position on the screen, only use random numbers
   * 0-200 in the x direction and 50-350 in the y direction
   * so that the text can't get too far off the screen */
  textFont(kannada, 48);
  
  text("The New Yorker", random(0,200), random(50,350));

  /* draw the text Luminari
   * using the luminari font to a random 
   * position on the screen */
  textFont(luminari, 48); 
  text("Luminari", random(0,200), random(50,350));
}

