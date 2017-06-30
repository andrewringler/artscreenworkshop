/*
 * Triangle Forest
 * by Thao Tran
 * 
 */
import artscreen.*;
import largesketchviewer.*;
import processing.video.*;

float[] pt1 = {1, 0};
float[] pt2 = {0.5, 0.5*sqrt(3)};
float trisize = 50;
PImage img;
int x = 0;

ArtScreen artScreen;

void setup() {
  size(1920, 1080, P2D);
  img = createImage(width, height, RGB);

  noStroke();
  background(150);

  /* NOTE this line will:
   * create a caption, fade-in/out your sketch over 1min, init the webcam, save a screenshot at 30seconds
   */
  artScreen = new ArtScreen(this, "Triangle Forest 2017", "by Thao Tran", "", color(255, 255, 255), color(0, 0, 0));
}

void draw() {  
  if (artScreen.captureFrameNumber < 5) {
    return; // wait for screen to start-up
  }

  // create image from webcam frame, scale-up to screen size
  img.copy(artScreen.captureFrame, 0, 0, artScreen.captureWidth, artScreen.captureHeight, 0, 0, img.width, img.height);
  img.loadPixels();

  // reset
  if (frameCount % 780 == 0) {
    rect(0, 0, width, height);
  }

  if (frameCount % 10 == 0) {
    float[][] lattice = makeLattice(trisize);
    int len = lattice.length;

    // random colored triangles
    for (int i = 0; i < 4; i = i + 1) {  
      int ind1 = floor(random(0, len - 0.1));
      float[] pt1 = lattice[ind1];
      color col = img.pixels[floor(pt1[0]) + width*floor(pt1[1])];
      downTriangleColor(col, pt1, trisize*floor(random(1, 3.9)));
    }

    // random triangles of webcam capture
    for (int i = 0; i < 4; i = i + 1) {  
      int ind2 = floor(random(0, len - 0.1));
      float[] pt2 = lattice[ind2];
      upTriangle(img, pt2, trisize*floor(random(3, 6)));
    }
  }
}



///////////

float[] addPoint(float[] p, float[] q) {
  float x0 = p[0] + q[0];
  float y0 = p[1] + q[1];

  float[] newpt = {x0, y0};
  return newpt;
}

float[] linCombo(float[] p, float[] q, float a, float b) {
  float x0 = a*p[0] + b*q[0];
  float y0 = a*p[1] + b*q[1];

  float[] newpt = {x0, y0};
  return newpt;
}

float[][] makeLattice(float side) {
  int rows = floor(width/side) + 1;
  int cols = floor(2*height/(sqrt(3)*side)) + 1;

  float[][] L = new float[rows*cols][2];
  int c = 0;

  for (int i = 0; i < rows; i = i + 1) {
    for (int j = 0; j < cols; j = j + 1) {
      if (j % 2 == 0) {
        L[c][0] = side * i;
      } else {
        L[c][0] = side * i + (side/2);
      }
      L[c][1] = j * side * (sqrt(3)/2);

      c = c + 1;
    }
  }

  return L;
}

void upTriangle(PImage texim, float[] top, float side) {
  beginShape(); 
  texture(texim);
  tint(255, 220);

  float[] v1 = linCombo(top, pt2, 1, side);
  float[] v2 = linCombo(v1, pt1, 1, -1*side);

  vertex(top[0], top[1], top[0], top[1]);
  vertex(v1[0], v1[1], v1[0], v1[1]);
  vertex(v2[0], v2[1], v2[0], v2[1]);
  endShape();
}

void downTriangle(PImage texim, float[] top, float side) {
  beginShape(); 
  texture(texim);

  float[] v1 = linCombo(top, pt1, 1, side);
  float[] v2 = linCombo(top, pt2, 1, side);

  vertex(top[0], top[1], top[0], top[1]);
  vertex(v1[0], v1[1], v1[0], v1[1]);
  vertex(v2[0], v2[1], v2[0], v2[1]);
  endShape();
}

void downTriangleColor(color c, float[] top, float side) {
  beginShape(); 
  fill(c);
  tint(255, 10);

  float[] v1 = linCombo(top, pt1, 1, side);
  float[] v2 = linCombo(top, pt2, 1, side);

  vertex(top[0], top[1], top[0], top[1]);
  vertex(v1[0], v1[1], v1[0], v1[1]);
  vertex(v2[0], v2[1], v2[0], v2[1]);
  endShape();
}

/////////////