// http://stackoverflow.com/questions/4756690/finding-image-silhouette-using-opencv
// adapted from OpenCV for Processing Background Subtraction example

import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;

import gab.opencv.*;

ArtScreen artScreen;
OpenCV opencv;
PImage smallerFrame; 
int processedFrame = 0;
ArrayList<Contour> contours;

void setup() {
  size(1920, 1080, P2D);

  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", color(255), color(0, 1));
  smallerFrame = createImage(round(artScreen.captureWidth / 4.0), round(artScreen.captureHeight / 4.0), RGB);
  opencv = new OpenCV(this, smallerFrame.width, smallerFrame.height);

  /*
Parameters:  
   history – Length of the history.
   nmixtures – Number of Gaussian mixtures.
   backgroundRatio – Background ratio.
   */
  opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {
  if (artScreen.captureFrameNumber < 5) {
    return;
  }

  background(0);

  if (processedFrame != artScreen.captureFrameNumber) {
    smallerFrame.copy(artScreen.captureFrame, 0, 0, artScreen.captureWidth, artScreen.captureHeight, 0, 0, smallerFrame.width, smallerFrame.height);  
    opencv.loadImage(smallerFrame);
    opencv.updateBackground();
    opencv.dilate();
    opencv.erode();
    contours = opencv.findContours();

    processedFrame = artScreen.captureFrameNumber;
  }

  if (contours != null) {
    scale(width / smallerFrame.height, height / smallerFrame.height);
    for (Contour contour : contours) {
      noStroke();
      fill(0, 255, 0);

      beginShape();
      //for (PVector point : contour.getPolygonApproximation().getPoints()) {
      //  vertex(point.x, point.y);
      //}
      for (PVector point : contour.getPoints()) {
        vertex(point.x, point.y);
      }
      endShape(CLOSE);
    }
  }
}