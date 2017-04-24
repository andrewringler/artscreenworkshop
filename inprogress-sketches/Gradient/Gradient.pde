// via BoofCV

// Converts the image from gray scale into binary and then finds the contour around each binary blob.
// Internal and external contours of each blob are drawn a different color.
import boofcv.processing.*;
import boofcv.struct.image.*;
import processing.video.*;

PImage imgContour;
PImage imgBlobs;
Capture video;    // processing video capture
PImage img0, img1, img2, img3;

void setup() {
  size(1600, 800, P3D);

  println(Capture.list());
  video = new Capture(this, 320, 240, 30); 
  //video = new Capture(this, "name=Live! Cam Chat HD VF0790,size=320x180,fps=15");
  //video = new Capture(this, "name=Live! Cam Chat HD VF0790,size=1280x720,fps=15");
  //video = new Capture(this, "name=Live! Cam Chat HD VF0790,size=640x360,fps=15");

  /*
  name=Live! Cam Chat HD VF0790,size=1280x720,fps=15 
   name=Live! Cam Chat HD VF0790,size=1280x720,fps=1 
   name=Live! Cam Chat HD VF0790,size=640x360,fps=30 
   name=Live! Cam Chat HD VF0790,size=640x360,fps=15 
   name=Live! Cam Chat HD VF0790,size=640x360,fps=1 
   name=Live! Cam Chat HD VF0790,size=320x180,fps=30 
   name=Live! Cam Chat HD VF0790,size=320x180,fps=15 
   name=Live! Cam Chat HD VF0790,size=320x180,fps=1 
   name=Live! Cam Chat HD VF0790,size=160x90,fps=30 
   name=Live! Cam Chat HD VF0790,size=160x90,fps=15
   name=Live! Cam Chat HD VF0790,size=160x90,fps=1 
   name=Live! Cam Chat HD VF0790,size=80x45,fps=30 
   name=Live! Cam Chat HD VF0790,size=80x45,fps=15 
   name=Live! Cam Chat HD VF0790,size=80x45,fps=1
   */


  //video = new Capture(this, "name=FaceTime HD Camera,size=320x180,fps=15");
  video.start(); // if on processing 151, comment this line
}

void draw() {
  if (video.available()) {
    video.read();

    // Convert the image into a simplified BoofCV data type
    PImage img = createImage(video.width, video.height, RGB);
    img.copy(video, 0, 0, video.width, video.height, 0, 0, img.width, img.height);
    SimpleGray gray = Boof.gray(video, ImageDataType.F32);

    //SimpleGradient gradient = gray.gradientSobel();
    //SimpleGradient gradient = gray.gradientPrewitt();
    SimpleGradient gradient = gray.gradientThree();
    //SimpleGradient gradient = gray.gradientTwo0();
    //SimpleGradient gradient = gray.gradientTwo1();
    // gradient will visualize its data into a single image
    img1 = gradient.visualize();
    // visualize the data for the x-derivative
    img2 = gradient.dx().visualizeSign();
    // visualize the data for the y-derivative
    img3 = gradient.dy().visualizeSign();

    //image(img, 0, 0);
    //image(img1, img1.width, 0);
    //image(img2, 0, img1.height);
    //image(img3, img1.width, img1.height);

    image(img1, 0, 0);
  }
}