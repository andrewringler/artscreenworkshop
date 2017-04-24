/*
 * Silhouette
 * by Andrew Ringler
 * 
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
PImage silhouette;
color silhouetteColor;
int timeSinceColorChange;

void setup() {
  size(1920, 1080, P3D);
  colorMode(RGB, 255);
  artScreen = new ArtScreen(this, "“Silhouette” 2017", "by Andrew Ringler", "", color(255), color(0, 1));

  silhouetteColor = color(random(0, 255), random(0, 255), random(0, 255));
  timeSinceColorChange = millis();
}

void draw() {
  if (artScreen.captureFrameNumber < 5) {
    return; // wait until motion images have stabilized
  }
  performMotionDetection();
  
  if (silhouette == null) {
    silhouette = createImage(motionImage.width, motionImage.height, ARGB);
  }

  if (millis() - timeSinceColorChange > 3000) {
    silhouetteColor = color(random(100, 255), random(100, 255), random(100, 255));
    timeSinceColorChange = millis();
  }

  background(0);

  // replace motion image with single color
  motionImage.loadPixels();
  silhouette.loadPixels();
  for (int x = 0; x < motionImage.width; x++) {
    for (int y = 0; y < motionImage.height; y++) {
      int loc = x + y * motionImage.width; //1D pixel location
      if (brightness(motionImage.pixels[loc]) > 3) {
        silhouette.pixels[loc] = silhouetteColor;
      } else {
        silhouette.pixels[loc] = color(0);
      }
    }
  }
  silhouette.updatePixels();

  image(silhouette, 0, 0, width, height); // stretch to fill screen

  //drawDebugInfo(); // uncomment to view debug information
}