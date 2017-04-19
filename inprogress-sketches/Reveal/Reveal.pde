/*
 * Reveal
 * 
 * Slowly reveals an image as people walk by
 */
import artscreen.*;
ArtScreen artScreen;
PImage originalArt;
PImage fadingMask, revealedBackground, motionMask;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "Earth – Bound 1, 2015", "by Sara Ringler", "Adapted for Art Screen by Andrew Ringler", color(0, 0, 0), color(255, 255, 255));
  originalArt = loadImage("SaraRingler_DSC_0089_1920x1080.png");

  fadingMask = createImage(width, height, ALPHA);
  motionMask = createImage(width, height, ALPHA);
  revealedBackground = createImage(width, height, ARGB);
}

void draw() {
  /* since we are rear-projecting our image will be
   * mirrored, so we want to flip it, so text reads correctly
   * and so that user's motion is as expected */
  scale(-1, 1);
  translate(-width, 0);

  background(0);

  // make a copy of our original image
  revealedBackground.copy(originalArt, 0, 0, originalArt.width, originalArt.height, 0, 0, revealedBackground.width, revealedBackground.height);

  // create a "mask" out of our motion image, at the scale of our screen
  motionMask.copy(artScreen.motionImage, 0, 0, artScreen.motionImage.width, artScreen.motionImage.height, 0, 0, width, height);

  // apply the new mask, to our existing mask, IE slowly
  // fade back to clear over time
  motionMask.loadPixels();
  fadingMask.loadPixels();
  for (int i=0; i<motionMask.pixels.length; i++) {
    // new mask is the current motion mask, plus some aspect of the next mask
    fadingMask.pixels[i] = color(constrain(int(alpha(motionMask.pixels[i]) + alpha(fadingMask.pixels[i])*.2f), 0, 255));
    //fadingMask.pixels[i] = color(blue(motionMask.pixels[i]), 0, 255);
  }
  fadingMask.updatePixels();

  // apply the mask to our image copy
  revealedBackground.mask(fadingMask);

  image(revealedBackground, 0, 0);
}