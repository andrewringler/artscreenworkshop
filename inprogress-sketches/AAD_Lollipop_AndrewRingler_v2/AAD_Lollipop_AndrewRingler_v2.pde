/*
 * Faces
 * by Andrew Ringler
 * 
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import gab.opencv.*;
ArtScreen artScreen;
OpenCV peopleDetector;
import java.awt.*;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“Lollipop” 2017", "by Andrew Ringler", "", color(255), color(0, 0));
}

void draw() {
  //if (artScreen.ready && peopleDetector == null) {
  //}

  if (artScreen.ready) {    
    peopleDetector = new OpenCV(this, artScreen.cam);
    peopleDetector.loadCascade(sketchPath() + "/data/LBP_PeopleDetection.xml", true);
    
    background(0);
    image(artScreen.cam, 0, 0, width, height);
    Size minSize = new Size(artScreen.cam.width * .05, artScreen.cam.height * .05);
    Size maxSize = new Size(artScreen.cam.width * .8, artScreen.cam.height * 1.1);

    // http://funvision.blogspot.com/2016/12/my-opencv-lbp-cascade-for-people.html
    // http://funvision.blogspot.com/2016/03/opencv-31-people-detection-at-13-fps-by.html
    Rectangle[] people = detect(peopleDetector, 1.02, 50, 0 | 1, minSize, maxSize);
    float scaleX = width / artScreen.cam.width;
    float scaleY = height / artScreen.cam.height;
    for (Rectangle person : people) {
      rect(person.x * scaleX, person.y * scaleY, person.width * scaleX, person.height * scaleY);
    }
  }
}