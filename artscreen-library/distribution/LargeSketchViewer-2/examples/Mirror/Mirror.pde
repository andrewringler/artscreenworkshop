/* Mirror
 * Mirror the preview window. This is useful if you are rear projecting
 * with your final screen
 */

// *** (Step 1) *** Import library line
import largesketchviewer.*;

void setup() {
  size(1920, 1080);

  // *** (Step 2) *** Create the small preview (initialize the library)
  // second argument true, states that we want to rotate our preview window
  LargeSketchViewer.smallPreview(this, false, 15, true);
}

void draw() {
  // we are rear projecting, so flip our image left-to-right
  scale(-1, 1);
  translate(-width, 0);

  background(80);
  textAlign(CENTER, CENTER);
  textSize(22);
  int size = 200;

  fill(255);
  ellipse(150, 150, size, size);
  fill(0);
  text("150,150", 150, 150);

  fill(255);
  ellipse(150, 930, size, size);
  fill(0);
  text("150,930", 150, 930);

  fill(255);
  ellipse(1770, 150, size, size);
  fill(0);
  text("1770,150", 1770, 150);

  fill(255);
  ellipse(1770, 930, size, size);
  fill(0);
  text("1770,930", 1770, 930);
}