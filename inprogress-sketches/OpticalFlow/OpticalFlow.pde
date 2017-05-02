import gab.opencv.*;
import processing.video.*;
import artscreen.*;
import largesketchviewer.*;

ArtScreen artScreen;
OpenCV opencv;
PImage smallerFrame; 
float DELTA = 0.5;

void setup() {
  size(1920, 1080, P2D);

  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", color(255), color(0, 1));
  smallerFrame = createImage(round(artScreen.captureWidth / 4.0), round(artScreen.captureHeight / 4.0), RGB);
  opencv = new OpenCV(this, smallerFrame.width, smallerFrame.height);
}

void draw() {
  if (artScreen.captureFrameNumber < 5) {
    return;
  }

  smallerFrame.copy(artScreen.captureFrame, 0, 0, artScreen.captureWidth, artScreen.captureHeight, 0, 0, smallerFrame.width, smallerFrame.height);
  opencv.loadImage(smallerFrame);
  opencv.calculateOpticalFlow();

  background(0);

  pushMatrix();
  scale(width / smallerFrame.width, height / smallerFrame.height);
  int stepSize = 4;
  for (int i=0; i<smallerFrame.width; i+=stepSize) {
    for (int j=0; j<smallerFrame.height; j+=stepSize) {
      PVector flow = opencv.getFlowAt(i, j);      
      strokeWeight(1/4.0);
      if (flow.x > DELTA || flow.y > DELTA) {
        if (flow.x > 0) {
          stroke(255, 0, 0);
        } else {
          stroke(0, 255, 0);
        }
        line(i, j, i+flow.x, j+flow.y);
      }
    }
  }
  popMatrix();

  // Draw average flow from center
  //PVector aveFlow = opencv.getAverageFlow();
  //int flowScale = 50;

  //stroke(255);
  //strokeWeight(2);
  //line(width/2, height/2, width/2 + aveFlow.x*flowScale, height/2 + aveFlow.y*flowScale);
}