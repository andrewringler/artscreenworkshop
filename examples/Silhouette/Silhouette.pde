/*
 * Silhouette
 * by Andrew Ringler
 * 
 */
import artscreen.*;
import largesketchviewer.*;
import processing.video.*;

ArtScreen artScreen;
ComputerVision computerVision;
Capture cam;

PImage silhouette;
color silhouetteColor;
int timeSinceColorChange;

void setup() {
  size(1920, 1080, P3D);
  artScreen = new ArtScreen(this, "Silhouette, 2017", "by Andrew Ringler", "Create art for this screen, take a free class! Info at artscreenworkshop.org", color(255), color(0));
  computerVision = new ComputerVision(artScreen, this);
  LargeSketchViewer.smallPreview(this, false, 15, true); // show smaller preview

  cam = new Capture(this, 1280, 720, 30);
  cam.start();

  silhouette = createImage(artScreen.motionImage.width, artScreen.motionImage.height, ARGB);
  silhouetteColor = color(random(0, 255), random(0, 255), random(0, 255));
  timeSinceColorChange = millis();
}

void draw() {
  if (cam.available()) {
    cam.read();
    computerVision.performCalculations(cam);
  }

  if (millis() - timeSinceColorChange > 1000) {
    silhouetteColor = color(random(0, 255), random(0, 255), random(0, 255));
    timeSinceColorChange = millis();
  }

  background(0);

  // replace motion image with single color
  artScreen.motionImage.loadPixels();
  silhouette.loadPixels();
  for (int x = 0; x < artScreen.motionImage.width; x++) {
    for (int y = 0; y < artScreen.motionImage.height; y++) {
      int loc = x + y * artScreen.motionImage.width; //1D pixel location
      if (blue(artScreen.motionImage.pixels[loc]) > 0) {
        silhouette.pixels[loc] = silhouetteColor;
      } else {
        silhouette.pixels[loc] = color(0);
      }
    }
  }
  silhouette.updatePixels();

  image(silhouette, 0, 0, width, height);
}