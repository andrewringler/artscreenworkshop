/* Empty
 * An empty sketch example
 * these are the bare minimum steps to start using the
 * Large Sketch Viewer library
 */

// *** (Step 1) *** Import library line
import largesketchviewer.*;

void setup() {
  size(1920, 1080, P3D);

  // *** (Step 2) *** Create the small preview (initialize the library)
  LargeSketchViewer.smallPreview(this);
}

void draw() {
  // your drawing code goes here as usual
}