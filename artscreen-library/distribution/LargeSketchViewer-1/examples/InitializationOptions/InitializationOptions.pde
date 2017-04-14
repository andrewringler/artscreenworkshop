/* InitializationOptions
 * Examples of ways of initializing the Large Sketch Viewer library
 */
 
// *** (Step 1) *** Import library line 
import largesketchviewer.*;

void setup() {
  size(1920, 1080);
  frameRate(60);
  
  // Various initialization examples, copy and paste one of the lines
  // into your sketch

  // Default settings
  //LargeSketchViewer.smallPreview(this);
  
  // Set framerate of preview window to about 15 frames per second
  LargeSketchViewer.smallPreview(this, 15);
}

void draw() {
  rectMode(CENTER);
  rect(width/2, height/2, 900, 800);
}