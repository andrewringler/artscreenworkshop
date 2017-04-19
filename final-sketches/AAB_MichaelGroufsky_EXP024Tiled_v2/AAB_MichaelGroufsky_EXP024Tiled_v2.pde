/*
 EXP024 Tiled
 by
 Michael
 Groufsky
 
 Experimatic day 24
 Randomly oriented tiles - click to rotate individual tiles.
 
 Creative Commons Attribution ShareAlike
 August 20th, 2013
 
 https://www.openprocessing.org/sketch/107042
 
 Adapted for Art Screen by Andrew Ringler
 
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;

ArtScreen artScreen;
int ROWS = 13;
int COLS = 22;
int[][] wedgeOrient = new int[ROWS][COLS];

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“EXP024 Tiled”, 2013", "by Michael Groufsky", "Adapted for Screen by Andrew Ringler", color(0xff), color(0xcc, 0x22, 0x00));

  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      wedgeOrient[i][j] = randomOrient();
    }
  }
}

void draw() {
  background(0xcc, 0x22, 0x00);
  noStroke();
  fill(0xff);
  for (int i = 1; i < ROWS - 1; i++) {
    float y = i * height / ROWS;
    for (int j = 1; j < COLS - 1; j++) {
      float x = j * width / COLS;
      wedge(x + 2, y + 2, int(width) / COLS - 4, float(height) / ROWS - 4, wedgeOrient[i][j]);
    }
  }

  if (artScreen.movementDetected) {
    PImage motionImage = artScreen.motionImage;
    motionImage.loadPixels();
    for (int x = 0; x < motionImage.width; x ++ ) {
      for (int y = 0; y < motionImage.height; y ++ ) {
        int loc = x + y*motionImage.width; //1D pixel location
        if (brightness(motionImage.pixels[loc]) > 220) {
          triggerOrientFlip(artScreen.cameraXToScreen(x, motionImage.width), artScreen.cameraYToScreen(y, motionImage.height));
        }
      }
    }

    //triggerOrientFlip(artScreen.motion.motionPixelX, artScreen.motion.motionPixelY);
  }
}

void wedge(float x, float y, float width, float height, int orient) {
  switch (orient) {
  case 0: // NE
    arc(x, y + height, 2 * width, 2 * height, 1.5 * PI, TWO_PI);
    break;
  case 1: // NW
    arc(x + width, y + height, 2 * width, 2 * height, PI, 1.5 * PI);
    break;
  case 2: // SW
    arc(x + width, y, 2 * width, 2 * height, 0.5 * PI, PI);
    break;
  case 3: // SE
    arc(x, y, 2 * width, 2 * height, 0, 0.5 * PI);
    break;
  }
}

int randomOrient() {
  return int(random(4));
}

void triggerOrientFlip(float x, float y) {
  int i = int(ROWS * y / height);
  int j = int(COLS * x / width);
  wedgeOrient[i][j] = (wedgeOrient[i][j] + 1) % 4;
  redraw();
}