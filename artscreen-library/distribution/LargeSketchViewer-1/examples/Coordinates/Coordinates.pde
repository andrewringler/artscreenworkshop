/* Coordinates
 * Display circles with coordinates of original large sketch size
 */

// *** (Step 1) *** Import library line
import largesketchviewer.*;

void setup() {
  size(1920, 1080);

  // *** (Step 2) *** Create the small preview (initialize the library)
  LargeSketchViewer.smallPreview(this);
}

void draw() {
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