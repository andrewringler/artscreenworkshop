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
import gab.opencv.*;
ArtScreen artScreen;
PImage originalArt;
PImage fadingMask, revealedBackground, motionMask;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Earth – Bound 1”, 2015", "by Sara Ringler", "Adapted for Art Screen by Andrew Ringler", color(255), color(0, 0, 0, 40));
  originalArt = loadImage("SaraRingler_DSC_0089_1920x1080.png");

  fadingMask = createImage(width, height, ARGB);
  motionMask = createImage(width, height, ARGB);
  revealedBackground = createImage(width, height, ARGB);
}

void draw() {
  background(0);

  if(frameCount < 10){
    // wait for motion frames to stabilize
    return;
  }

  // make a copy of our original image
  revealedBackground.copy(originalArt, 0, 0, originalArt.width, originalArt.height, 0, 0, revealedBackground.width, revealedBackground.height);

  // create a "mask" out of our motion image
  motionMask.copy(artScreen.motionImage, 0, 0, artScreen.motionImage.width, artScreen.motionImage.height, 0, 0, width, height);

  // apply the new mask, to our existing mask, IE slowly
  // fade back to clear over time
  motionMask.loadPixels();
  fadingMask.loadPixels();
  for (int i=0; i<motionMask.pixels.length; i++) {
    // new mask is the current motion mask, plus some aspect of the next mask
    fadingMask.pixels[i] = color(constrain(int(blue(motionMask.pixels[i]) + blue(fadingMask.pixels[i])*.95f), 0, 255));
    //fadingMask.pixels[i] = color(blue(motionMask.pixels[i])); // lets only current motion frame through
    //fadingMask.pixels[i] = color(0); // lets nothing through
    //fadingMask.pixels[i] = color(255); // lets everything through
  }
  fadingMask.updatePixels();

  // apply the mask to our image copy
  revealedBackground.mask(fadingMask);

  image(revealedBackground, 0, 0);
}