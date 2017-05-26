/*
 * Tile Spin
 * by Andrew Ringler
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import java.util.*;

ArtScreen artScreen;

int TILE_SIZE = 5;
int MAX_TILE_LIFE_MILLIS = 800; 
List<Tile> tiles = new ArrayList<Tile>();

void setup() {
  size(1920, 1080, P3D);

  /* NOTE this line will:
   * create a caption, fade-in/out your sketch over 1min, init the webcam, save a screenshot at 30seconds
   */
  artScreen = new ArtScreen(this, "“Tile Spin” 2017", "by Andrew Ringler", "", color(255), color(0, 1));
}

void draw() {
  background(0);

  // KEEP required for simple motion detection: movementDetected, maxMotionLocation, top100MotionPixels etc…
  performMotionDetection();

  // wait for motion to stabilize
  if (artScreen.captureFrameNumber < 5) {
    return; // quit this draw() early
  }

  // loop over sections of our motion image, create square tiles
  // wherever there is motion detected
  if (frameCount % 3 == 0) {
    motionImage.loadPixels();
    for (int i=0; i<motionImage.width-TILE_SIZE; i+=TILE_SIZE) {
      for (int j=0; j<motionImage.height-TILE_SIZE; j+=TILE_SIZE) {
        int loc = i + j * motionImage.width; //1D pixel location
        if (motionImage.pixels[loc] != transparentBlack) {
          // create a new tile, creating a slice of captureImage with
          // the current pixel being analzyed in the top-left corner
          PImage tileImage = createImage(TILE_SIZE, TILE_SIZE, ARGB);
          tileImage.copy(processingFrame, i, j, TILE_SIZE, TILE_SIZE, 0, 0, TILE_SIZE, TILE_SIZE);
          tiles.add(new Tile(tileImage, new PVector(i, j, 0)));
        }
      }
    }
  }

  // draw tiles
  //lights();
  //ambientLight(200, 200, 200);
  //directionalLight(255, 255, 255, 0, -1, 0);
  scale((float)width / motionImage.width, (float)height / motionImage.height, 0);
  for (Tile tile : tiles) {
    tile.drawTile();
  }

  // remove expired tiles
  Iterator<Tile> tilesIterator = tiles.iterator();
  while (tilesIterator.hasNext()) {
    Tile tile = tilesIterator.next();
    if (millis() - tile.birthTimeMillis > MAX_TILE_LIFE_MILLIS) {
      tilesIterator.remove();
    }
  }  

  // update tile position and spin
  for (Tile tile : tiles) {
    tile.update();
  }
}

class Tile {
  PImage tileImage;
  PVector location;
  PVector angle = new PVector(random(-TWO_PI, TWO_PI),random(-TWO_PI, TWO_PI),random(-TWO_PI, TWO_PI));
  int birthTimeMillis = millis();
  float spinAngle = 0;

  public Tile(PImage tileImage, PVector location) {
    this.tileImage = tileImage;
    this.location = location;
  }

  public void update() {
    if ((millis() - birthTimeMillis) > 200) { 
      spinAngle += PI/6.0;

      // move in the direction of our our target angle
      // https://stackoverflow.com/questions/4642687/given-start-point-angles-in-each-rotational-axis-and-a-direction-calculate-end
      location.x += cos(angle.x) * 15;
      location.y += sin(angle.y) * 15;
      //location.z += cos(angle.z) * cos(angle.z) * 15;
    }
  }

  public void drawTile() {
    // if young don't draw
    if (millis() - birthTimeMillis < 200) {
      return;
    }

    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y, location.z);
    rotateX(spinAngle);
    rotateY(spinAngle);
    rotateZ(spinAngle);

    float pctLife = (float)(millis() - birthTimeMillis) / MAX_TILE_LIFE_MILLIS;
    tint(255, 255 - pctLife*255); // semi-transparent
    
    //image(tileImage, 0, 0);
    scale(TILE_SIZE, TILE_SIZE, TILE_SIZE);
    new ImageCube(tileImage).drawImageCube();
    popMatrix();
  }
}