/*
 * Contours, 2015
 * by Peter Abeles
 * Adapted for Art Screen by Andrew Ringler
 * 
 * Description:
 * Converts the video frames from gray scale into binary and then finds the contour around each binary blob.
 * Internal and external contours of each blob are drawn a different color.
 *
 * Nov 10, 2015 @lessthanoptimal lessthanoptimal Updated for Processing 3
 * Apache License 2.0
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import boofcv.processing.*;
import boofcv.struct.image.*;
import java.util.concurrent.atomic.AtomicBoolean;

ArtScreen artScreen;
int processedFrameNumber = -1;

SimpleDenseOpticalFlow flow;
final AtomicBoolean processingContour = new AtomicBoolean(false);
SimpleGray gray;
ResultsBlob results;

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“BoofCV: Contours” 2015", "by Peter Abeles", "Adapted for Art Screen by Andrew Ringler", color(255), color(0, 0, 0, 1));
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 5) {
    return; // wait until motion images have stabilized
  }

  // run processing in a separate thread, it can be slow
  if (processingContour.compareAndSet(false, true)) {
    gray = Boof.gray(processingFrame, ImageDataType.F32);

    thread("processContour");
  }

  if (results != null) {
    PImage imgContour = results.getContours().visualize();
    image(imgContour, 0, 0, width, height); // display contour and stretch to screen size
  }
}

void processContour() {
  // Threshold the image using its mean value
  double threshold = gray.mean();
  
  // find blobs and contour of the particles
  results = gray.threshold(threshold, true).erode8(1).contour();

  processingContour.set(false);
}