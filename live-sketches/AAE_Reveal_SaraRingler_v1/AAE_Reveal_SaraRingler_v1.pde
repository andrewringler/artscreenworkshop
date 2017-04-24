/*
 * Reveal
 * by Sara Ringler
 * adapted for Art Screen by Andrew Ringler
 * 
 * Slowly reveals an image as people walk by
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
PImage originalArt;
PImage fadingMask, revealedBackground, motionMask;
boolean firstMask = true;
int processedFrameNumber = -1;

void setup() {
  size(1920, 1080);
  colorMode(RGB, 255);

  artScreen = new ArtScreen(this, "“Earth – Bound 1”, 2015", "by Sara Ringler", "Adapted for Art Screen by Andrew Ringler", color(255), color(0, 0, 0, 40));
  originalArt = loadImage("SaraRingler_DSC_0089_1920x1080.png");

  fadingMask = createImage(width, height, RGB);
  motionMask = createImage(width, height, RGB);
  revealedBackground = createImage(width, height, ARGB);
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 5) {
    // wait for motion frames to stabilize
    return;
  }

  if (processedFrameNumber != artScreen.captureFrameNumber) {
    // create a "mask" out of our motion image
    motionMask.copy(motionImage, 0, 0, motionImage.width, motionImage.height, 0, 0, width, height);

    // apply the new mask, to our existing mask, IE slowly
    // fade back to clear over time
    motionMask.loadPixels();
    fadingMask.loadPixels();
    for (int i=0; i<motionMask.pixels.length; i++) {
      if (firstMask) {
        // new mask is just the current motion mask
        fadingMask.pixels[i] = color(constrain(int(round(motionMask.pixels[i] & 0xFF)), 0, 255)); // & 0xFF is blue in RGB 255 https://processing.org/reference/blue_.html
      } else {
        // new mask is the previous motion mask, plus some aspect of the next mask
        fadingMask.pixels[i] = color(constrain(int(round(motionMask.pixels[i] & 0xFF)) + int((fadingMask.pixels[i] & 0xFF)*.95f), 0, 255));
      }
    }
    fadingMask.updatePixels();
    firstMask = false;

    // make a copy of our original image
    revealedBackground.copy(originalArt, 0, 0, originalArt.width, originalArt.height, 0, 0, revealedBackground.width, revealedBackground.height);

    // apply the mask to our image copy
    revealedBackground.mask(fadingMask);

    processedFrameNumber = artScreen.captureFrameNumber;
  }

  background(0);
  image(revealedBackground, 0, 0);
}