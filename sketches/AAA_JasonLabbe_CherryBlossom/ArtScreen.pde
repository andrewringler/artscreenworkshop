/*
 * Some code taken from flob examples http://s373.net/code/flob
 * copyright (c) André Sier 2008-2012
 */
import processing.core.*;
import processing.opengl.*;
import processing.video.*;
import largesketchviewer.*;

public class ArtScreen {
  PApplet p;
  String titleOfArtwork, artistFullName, additionalCredits;
  int duration = 15000; // small duration for testing

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
  Motion motion;

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

  public ArtScreen(PApplet p, String titleOfArtwork, String artistFullName, String additionalCredits) {
    this.p = p;
    this.titleOfArtwork = titleOfArtwork;
    this.artistFullName = artistFullName;
    this.additionalCredits = additionalCredits;
    p.registerMethod("pre", this);
    p.registerMethod("draw", this);

    if (args != null && args.length != 0 && args[0].equals("live")) {
      // no preview
    } else {
      LargeSketchViewer.smallPreview(p); // show smaller preview
    }
    if (args != null && args.length >= 2) {
      try {
        int requestedDuration = Integer.parseInt(args[1]);
        if (requestedDuration > 1000) {
          duration = requestedDuration;
        }
      }
      catch(NumberFormatException e) {
        // ignore
      }
    }


    video = new Capture(p, CAPTURE_WIDTH, CAPTURE_HEIGHT, (int)fps); 
    video.start(); // if on processing 151, comment this line 

    motion = new Motion(video);

    scaleX = width / (float)CAPTURE_WIDTH;
    scaleY = height / (float)CAPTURE_HEIGHT;

    openSansSemiBold22 = loadFont("OpenSans-Semibold-22.vlw");
    openSansSemiBoldItalic22 = loadFont("OpenSans-SemiboldItalic-22.vlw");
    openSansSemiBold16 = loadFont("OpenSans-Semibold-16.vlw");

    pushStyle();
    colorMode(RGB, 255);
    background(0);
    popStyle();

    noCursor();
  }

  // Method that's called just after beginDraw(), meaning that it can affect drawing.
  void pre() {
    if (video.available() == true) {
      video.read();
      motion.update();
    }
  }

  // Method that's called at the end of draw(), but before endDraw().
  void draw() {
    drawArtworkCaption(titleOfArtwork, artistFullName, additionalCredits);

    if (millis() >= duration) {
      // enough time has passed, exit Sketch
      // so the next Sketch may start
      exit();
    }
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