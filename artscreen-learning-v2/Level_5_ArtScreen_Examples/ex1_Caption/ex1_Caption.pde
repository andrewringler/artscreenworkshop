/*
 * caption:
 * this is the minimal amount of code required to display
 * your work on the Art Screen
 *
 * this sketch:
 * 1) displays a caption in the bottom right-hand corner
 * 2) automatically quits after 1-minute, to let other sketches run
 * 3) loads a preview window that is non-mirrored and small enough to display on any laptop screen
 * 4) automatically saves a frame at around 30-seconds
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;

void setup() {
  // all sketches must be 1920x1080, that is the resolution of the projector of Art Screen
  size(1920, 1080, P2D);
  
  /* Replace title with the title of your work and 2017 with current date
   * Your Name should be the name of you and your collaborators
   * 3rd line you should use to credit any code your remixxed from
   *
   * color(255) is the text color
   * color(0, 1) is the background color, use 1 for transparent 
   */
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "3rd line", color(255), color(0, 1));
}

void draw() {
  // nothing
}