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
ArtScreen artScreen;
int ROWS = 12;
int COLS = 18;
int[][] wedgeOrient = new int[ROWS][COLS];

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "EXP024 Tiled", "by Michael Groufsky", "Ported to Art Screen by Andrew Ringler", color(0xff), color(0xcc, 0x22, 0x00));

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

  if (artScreen.motion.movementDetected) {
    triggerOrientFlip(artScreen.motion.motionPixelX, artScreen.motion.motionPixelY);
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

void triggerOrientFlip(int x, int y) {
  int i = int(ROWS * y / height);
  int j = int(COLS * x / width);
  wedgeOrient[i][j] = (wedgeOrient[i][j] + 1) % 4;
  redraw();
}