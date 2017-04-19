/**
 * Ignore Styles. 
 * Illustration by George Brower. 
 * 
 * Shapes are loaded with style information that tells them how
 * to draw (the color, stroke weight, etc.) The disableStyle() 
 * method of PShape turns off this information. The enableStyle()
 * method turns it back on.
 */

// adapted from https://github.com/processing/processing-docs/tree/master/content/examples/Basics/Shape/DisableStyle
// https://processing.org/examples/disablestyle.html

PShape bot;

void setup() {
  size(640, 360);
  
  // The file "bot1.svg" must be in the data folder
  // of the current sketch to load successfully
  bot = loadShape("bot1.svg");
  noLoop();
} 

void draw() {
  background(102);
  
  // Draw left bot
  bot.disableStyle();  // Ignore the colors in the SVG
  fill(0, 102, 153);    // Set the SVG fill to blue
  stroke(255);          // Set the SVG stroke to white
  shape(bot, 20, 25, 300, 300);

  // Draw the bot on the right with
  // original style information from the SVG file
  bot.enableStyle();
  shape(bot, 320, 25, 300, 300);
}
