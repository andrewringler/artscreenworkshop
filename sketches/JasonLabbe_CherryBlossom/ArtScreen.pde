/*
 * Some code taken from flob examples http://s373.net/code/flob
 * copyright (c) André Sier 2008-2012
 */
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;
import largesketchviewer.*;

// Captions
int CAPTION_HEIGHT = 80;
int CAPTION_MARGIN_RIGHT = 30;
int CAPTION_MARGIN_TOP = 8;
int CAPTION_LINE_HEIGHT = 24;
int CAPTION_Y_OFFSET = 0;
PFont openSansSemiBold22;
PFont openSansSemiBoldItalic22;
PFont openSansSemiBold16;

// Video Processing
Capture video;    // processing video capture
int CAPTURE_WIDTH = 1280;
int CAPTURE_HEIGHT = 720;
Flob flob;        // flob tracker instance
Motion motion;
ArrayList<Blob> blobs = new ArrayList();  // an optional ArrayList to hold the gathered blobs
PImage videoinput;// a downgraded image to flob as input

// config params
int tresh = 10;   // adjust treshold value here or keys t/T
int fade = 55;
int om = 1;
int videores=128;//64//256
String info="";
PFont font;
float fps = 30;
int videotex = 3;

float scaleX, scaleY; 

void initializeArtScreen() {
  pushStyle();
  LargeSketchViewer.smallPreview(this); // show smaller preview

  video = new Capture(this, CAPTURE_WIDTH, CAPTURE_HEIGHT, (int)fps); 
  video.start(); // if on processing 151, comment this line 

  motion = new Motion(video);

  scaleX = width / (float)CAPTURE_WIDTH;
  scaleY = height / (float)CAPTURE_HEIGHT;

  // init flob
  // flob uses construtor to specify srcDimX, srcDimY, dstDimX, dstDimY
  // srcDim should be video input dimensions
  // dstDim should be desired output dimensions  

  // create one image with the dimensions you want flob to run at
  videoinput = createImage(videores, videores, RGB);

  // constructor usages
  // specifying srcDim thru videoinput, dstDim == sketch width, height
  flob = new Flob(this, videoinput);
  // specify all arguments, this, srcx, srcy, dstx, dsty
  // flob = new Flob(this, videores, videores, width, height); 

  flob.setTresh(tresh); //set the new threshold to the binarize engine
  flob.setThresh(tresh); //typo
  flob.setSrcImage(videotex);
  flob.setImage(videotex); //  pimage i = flob.get(Src)Image();

  flob.setBackground(videoinput); // zero background to contents of video
  flob.setBlur(0); //new : fastblur filter inside binarize
  flob.setMirror(true, false);
  flob.setOm(0); //flob.setOm(flob.STATIC_DIFFERENCE);
  flob.setOm(1); //flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setFade(fade); //only in continuous difference

  // or now just concatenate messages
  flob.setThresh(tresh).setSrcImage(videotex).setBackground(videoinput)
    .setBlur(0).setOm(1).setFade(fade).setMirror(true, false);
  ;

  openSansSemiBold22 = loadFont("OpenSans-Semibold-22.vlw");
  openSansSemiBoldItalic22 = loadFont("OpenSans-SemiboldItalic-22.vlw");
  openSansSemiBold16 = loadFont("OpenSans-Semibold-16.vlw");

  colorMode(RGB, 255);
  background(0);
  
  popStyle();  
}

void captureEvent(Capture c) {
  pushStyle();
  video.read();
  //downscale video image to videoinput pimage
  videoinput.copy(video, 0, 0, 320, 240, 0, 0, videores, videores);

  ArrayList<ABlob> ablobs = flob.calc(flob.binarize(videoinput));

  // Convert flobs ABlobs, to our blobs
  ArrayList<Blob> newBlobs = new ArrayList();
  for (ABlob ablob : ablobs) {
    Blob blob = new Blob(ablob);
    newBlobs.add(blob);
  }
  blobs = newBlobs;

  motion.update();

  popStyle();
}

void drawArtworkCaption(String titleOfArtwork, String artistFullName, String additionalCredits) {
  float yTop = height-CAPTION_HEIGHT-CAPTION_Y_OFFSET;
  float captionTop = yTop+CAPTION_MARGIN_TOP;
  
  pushStyle();
  pushMatrix();
  colorMode(RGB, 255);
  translate(width, 0);
  scale(-1, 1);
  noStroke();
  fill(0);
  rect(width*2f/3f, yTop, width/3.0, CAPTION_HEIGHT);

  fill(255, 255, 255);
  textAlign(RIGHT, TOP);
  textFont(openSansSemiBoldItalic22);
  text("“" + titleOfArtwork + "”", width-CAPTION_MARGIN_RIGHT, captionTop);
  textFont(openSansSemiBold22);
  text("by " + artistFullName, width-CAPTION_MARGIN_RIGHT, captionTop+CAPTION_LINE_HEIGHT);
  textFont(openSansSemiBold16);
  text(additionalCredits, width-CAPTION_MARGIN_RIGHT, captionTop+2*CAPTION_LINE_HEIGHT);
  popMatrix();
  popStyle();
}

class Motion {
  int THRESHOLD = 80;
  boolean movementDetected = false;
  int motionPixelX = 0;
  int motionPixelY = 0;
  PImage pImage;
  Capture capture;

  public Motion(Capture capture) {
    this.capture = capture;
    pImage = createImage(capture.width, capture.height, RGB); // Create an empty image for staging the image the same size as the video
  }

  void update() {
    pImage.loadPixels();
    capture.loadPixels();

    float maxChange = 0;
    boolean newMotion = false;
    int newX = 0;
    int newY = 0;
    for (int x = 0; x < pImage.width; x ++ ) {
      for (int y = 0; y < pImage.height; y ++ ) {
        int loc = x + y*pImage.width; //1D pixel location
        int oldR = round(red(pImage.pixels[loc]));
        int oldG = round(green(pImage.pixels[loc]));
        int oldB = round(blue(pImage.pixels[loc]));
        int newR = round(red(capture.pixels[loc]));
        int newG = round(green(capture.pixels[loc]));
        int newB = round(blue(capture.pixels[loc]));

        float change = dist(oldR, oldG, oldB, newR, newG, newB);
        if (change > THRESHOLD && change > maxChange) {
          newMotion = true;
          newX = x;
          newY = y;
        }
      }
    }

    movementDetected = newMotion;
    motionPixelX = newX;
    motionPixelY =  newY;
    // save current frame to old
    pImage.copy(capture, 0, 0, capture.width, capture.height, 0, 0, pImage.width, pImage.height);
  }
}
class Blob {
  public final float x, y, blobWidth, blobHeight;
  public color dominantColor;

  public Blob(ABlob ablob) {
    x = ablob.cx;
    y = ablob.cy;
    blobWidth = ablob.dimx;
    blobHeight = ablob.dimy;

    calculateDominantColor();
  }

  void calculateDominantColor() {
    int sx = int(x / scaleX);
    int sy = int(y / scaleY);
    int sw = int(blobWidth / scaleX);
    int sh = int(blobHeight / scaleY);
    PImage blobRegion = createImage(sw, sh, RGB);
    blobRegion.copy(videoinput, sx, sy, sw, sh, 0, 0, sw, sh);
    //dominantColor = getDominantColor(blobRegion);
  }
}

// from https://cate.blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/
color getDominantColor(PImage img) {
  int hueRange = 320; 
  colorMode(HSB, (hueRange - 1), 1, 1, 1);
  img.loadPixels();
  int numberOfPixels = img.pixels.length;
  int[] hues = new int[hueRange];
  float[] saturations = new float[hueRange];
  float[] brightnesses = new float[hueRange];

  for (int i = 0; i < numberOfPixels; i++) {
    int pixel = img.pixels[i];
    float curBrightness = brightness(pixel);
    float curSaturation = saturation(pixel);
    int hueIndex = Math.round(hue(pixel));
    hues[hueIndex]++;
    saturations[hueIndex] += curSaturation;
    brightnesses[hueIndex] += curBrightness;
  }

  // Find the most common hue.
  int hueCount = hues[0];
  int curHue = 0;
  for (int i = 1; i < hues.length; i++) {
    if (hues[i] > hueCount) {
      hueCount = hues[i];
      curHue = i;
    }
  }

  // Set the vars for displaying the color.
  float hue = curHue;
  float saturation = saturations[curHue] / (float)hueCount;
  float brightness = brightnesses[curHue] / (float)hueCount;

  color dominantColor = color(hue, saturation, brightness);

  return dominantColor;
}