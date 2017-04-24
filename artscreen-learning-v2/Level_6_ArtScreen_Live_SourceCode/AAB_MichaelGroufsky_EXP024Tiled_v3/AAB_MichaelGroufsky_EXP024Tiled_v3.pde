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

ArtScreen artScreen;
int ROWS = 13;
int COLS = 22;
int HOLD_COLOR_TIME_MILLIS = 150;
int[][] wedgeOrient = new int[ROWS][COLS];
int[][] wedgeLastFlipTimeMillis = new int[ROWS][COLS];
int marginX = 50;
float gridWidth = 1920 - marginX;
float gridHeight = 1080 - 150;

void setup() {
  size(1920, 1080, P2D);
  colorMode(RGB, 255);
  artScreen = new ArtScreen(this, "“EXP024 Tiled”, 2013", "by Michael Groufsky", "Adapted for Screen by Andrew Ringler", color(0xff), color(0));

  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      wedgeOrient[i][j] = randomOrient();
      wedgeLastFlipTimeMillis[i][j] = 0;
    }
  }
}

void draw() {
  performMotionDetection();

  if (movementDetected) {
    motionImage.loadPixels();
    for (int x = 0; x < motionImage.width; x ++ ) {
      for (int y = 0; y < motionImage.height; y ++ ) {
        int loc = x + y*motionImage.width; //1D pixel location
        if ((motionImage.pixels[loc] & 0xFF) > 20f) { // & 0xFF is blue in RGB,255 mode, https://processing.org/reference/blue_.html
          triggerOrientFlip(toScreenX(x, motionImage.width), toScreenY(y, motionImage.height));
        }
      }
    }
  }

  //background(0xcc, 0x22, 0x00);
  background(0);
  noStroke();
  translate(marginX / 2f, 0);
  for (int i = 1; i < ROWS - 1; i++) {
    float y = i * gridHeight / ROWS;
    for (int j = 1; j < COLS - 1; j++) {
      float x = j * gridWidth / COLS;
      fill(0xff);
      if(millis() - wedgeLastFlipTimeMillis[i][j] < HOLD_COLOR_TIME_MILLIS){
        fill(185, 252, 255);
      }
      wedge(x + 2, y + 2, int(gridWidth) / COLS - 4, gridHeight / ROWS - 4, wedgeOrient[i][j]);
    }
  }

  //drawDebugInfo(); // uncomment to view debug information
}

void wedge(float x, float y, float wedthWidth, float wedgeHeight, int orient) {
  switch (orient) {
  case 0: // NE
    arc(x, y + wedgeHeight, 2 * wedthWidth, 2 * wedgeHeight, 1.5 * PI, TWO_PI);
    break;
  case 1: // NW
    arc(x + wedthWidth, y + wedgeHeight, 2 * wedthWidth, 2 * wedgeHeight, PI, 1.5 * PI);
    break;
  case 2: // SW
    arc(x + wedthWidth, y, 2 * wedthWidth, 2 * wedgeHeight, 0.5 * PI, PI);
    break;
  case 3: // SE
    arc(x, y, 2 * wedthWidth, 2 * wedgeHeight, 0, 0.5 * PI);
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
  wedgeLastFlipTimeMillis[i][j] = millis();
}