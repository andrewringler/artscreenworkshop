/* PerformanceTests
 * Animation examples to test performance of this library
 */
 
// *** (Step 1) *** Import library line
import largesketchviewer.*;

float rectSize = 10;
boolean rectGrowing = true;

void setup() {
  size(1920, 1080, P3D);
  frameRate(60);
  background(0);
  
  // Initialize preview, set frameRate of preview window to about 5 frames per second
  LargeSketchViewer.smallPreview(this, 5);
}

void draw() {
  background(0);
  rectMode(CENTER);
  translate(width/2, height/2);
  rotate((frameCount % 300.0)/300.0 * TWO_PI);
  rect(0, 0, 900, 800);
}