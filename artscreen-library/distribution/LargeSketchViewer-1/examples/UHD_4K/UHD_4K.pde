/* UHD_4K
 * Targeting a Ultra HD 4K TV
 * with a resolution of 3,840 x 2,160
 */

// *** (Step 1) *** Import library line
import largesketchviewer.*;

void setup() {
  size(3840,2160);

  // *** (Step 2) *** Create the small preview (initialize the library)
  LargeSketchViewer.smallPreview(this);
}

void draw() {
  // your drawing code goes here as usual
}