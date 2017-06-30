/*
 * numberOfMotionPixels:
 * displays an ellipse with size varying depending on the total number of pixels in “motion”
 * displays a second ellipse with motion smoothed out over time
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
float numberOfMotionPixelsAvg = 0; 

void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "3rd line", color(255), color(0, 1));
}

void draw() {
  // this should be the first line in the draw function
  // it performs all the motion calculations
  performMotionDetection();

  /* we typically want to wait a few frames until
   * the motion has stabilized, before we draw anything */
  if (artScreen.captureFrameNumber < 5) {
    return;
  }

  // clear the background, so we don't leave motion trails
  background(0);

  /*
   * 20                      - min circle size
   * numberOfMotionPixels    - total number of pixels that have changed between current frame and previous
   * artScreen.captureWidth * artScreen.captureHeight
                             - total number of pixels in the capture frame
                             - we multiple by 0.01 because in practice we will rarely have all pixels moving
                             - so we assume no more than 1% of total pixels will ever be in motion
   * then multiple by 400, that will be our maximum circle size
   */
  float pctPixelsInMotion = constrain(numberOfMotionPixels / (artScreen.captureWidth * artScreen.captureHeight * 0.01), 0, 1);
  float circleSize = 20 + pctPixelsInMotion * 400;
  noStroke();
  fill(255);
  ellipse(width/3.0, height/2.0, circleSize, circleSize);
  
  // create a circle whose size is smoothed over time
  // in response to total motion
  numberOfMotionPixelsAvg = numberOfMotionPixelsAvg + (numberOfMotionPixels - numberOfMotionPixelsAvg) * 0.1;
  float avgCircleSize = 20 + constrain(numberOfMotionPixelsAvg / (artScreen.captureWidth * artScreen.captureHeight * 0.01), 0, 1) * 400;
  ellipse(width * (2.0/3.0), height/2.0, avgCircleSize, avgCircleSize);  
}