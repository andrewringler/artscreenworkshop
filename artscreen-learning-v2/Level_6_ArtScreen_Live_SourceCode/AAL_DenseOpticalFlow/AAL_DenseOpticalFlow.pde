/*
 * Dense Optical Flow, 2015
 * by Peter Abeles
 * Adapted for Art Screen by Andrew Ringler
 * 
 * Description:
 * Compares two images from a sequence and finds the motion of each pixel from the first
 * image to the second image
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
final AtomicBoolean processingFlow = new AtomicBoolean(false);
PImage image0;
PImage image1;

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“BoofCV: Dense Optical Flow” 2015", "by Peter Abeles", "Credits: Andrew Ringler, Horn-Schunck-Pyramid", color(255), color(0, 0, 0, 1));
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 5) {
    return; // wait until motion images have stabilized
  }

  if (image0 == null) {
    image0 = createImage(processingFrame.width / 3, processingFrame.height / 3, RGB);
    image1 = createImage(processingFrame.width / 3, processingFrame.height / 3, RGB);
  }

  // run flow processing in a separate thread, it can be slow
  if (processingFlow.compareAndSet(false, true)) {
    image0.copy(previousProcessingFrame, 0, 0, previousProcessingFrame.width, previousProcessingFrame.height, 0, 0, image0.width, image0.height); 
    image1.copy(processingFrame, 0, 0, processingFrame.width, processingFrame.height, 0, 0, image1.width, image1.height);
    image0.filter(GRAY);
    image1.filter(GRAY);

    thread("processFlow");
  }

  if (flow != null) {
    PImage outputFlow = flow.visualizeFlow();
    image(outputFlow, 0, 0, width, height); // display flow and stretch to screen size
  }
}

void processFlow() {
  // process the flow from the input images
  SimpleDenseOpticalFlow newFlow = Boof.flowHornSchunckPyramid(null, ImageDataType.F32);
  
  // Other flow algorithms, vary in output and performance
  //SimpleDenseOpticalFlow newFlow = Boof.flowBroxWarping(null,ImageDataType.F32);
  //SimpleDenseOpticalFlow newFlow = Boof.flowKlt(null,6,ImageDataType.F32);
  //SimpleDenseOpticalFlow newFlow = Boof.flowRegion(null,ImageDataType.F32);
  //SimpleDenseOpticalFlow newFlow = Boof.flowHornSchunck(null,ImageDataType.F32);

  newFlow.process(image0, image1);

  flow = newFlow;
  processingFlow.set(false);
}