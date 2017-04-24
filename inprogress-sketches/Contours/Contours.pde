// via BoofCV

// Converts the image from gray scale into binary and then finds the contour around each binary blob.
// Internal and external contours of each blob are drawn a different color.
import boofcv.processing.*;
import boofcv.struct.image.*;
import processing.video.*;

PImage imgContour;
PImage imgBlobs;
Capture video;    // processing video capture

void setup() {
  size(320, 180, P3D);

  println(Capture.list());
  //video = new Capture(this, 320, 240, 30); 
  //video = new Capture(this, "name=Live! Cam Chat HD VF0790,size=320x180,fps=15");
  video = new Capture(this, "name=FaceTime HD Camera,size=320x180,fps=15");
  video.start(); // if on processing 151, comment this line
}

void draw() {
  if (video.available()) {
    video.read();

    // Convert the image into a simplified BoofCV data type
    PImage img = createImage(320, 240, RGB);
    img.copy(video, 0, 0, video.width, video.height, 0, 0, img.width, img.height);
    //SimpleGray gray = Boof.gray(img, ImageDataType.U8);
    SimpleGray gray = Boof.gray(video, ImageDataType.F32);

    //image(gray.convert(), 0, 0, width, height);
    
    // Threshold the image using its mean value
    double threshold = gray.mean();
    //double threshold = gray.min();
    //double threshold = 0.9;
    println(threshold);
    // find blobs and contour of the particles
    ResultsBlob results = gray.threshold(threshold, true).erode8(1).contour();

    // Visualize the results
    imgContour = results.getContours().visualize();
    imgBlobs = results.getLabeledImage().visualize();
  }

  if (imgBlobs != null) {
    background(0);
    if ( mousePressed ) {
      image(imgBlobs, 0, 0);
    } else {
      image(imgContour, 0, 0);
    }
  }
}