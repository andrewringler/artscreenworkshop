These are all Sketches written in the Processing language.
To run them you need to:

1. Download and install Processing, https://processing.org/
2. Launch Processing and install additional libraries:
    Sketch | Import Library… | Add Library… | Click on library, then Install button
    
    You should install the following libraries:
    Video, OpenCV for Processing, BoofCV for Processing, PixelFlow


** Check out examples from Level 1-4 to learn the Processing Language

** or if you are familiar with Processing already
   just jump straight to Level 5 or 6 Art Screen Examples
   to see how you can create new interactive content for the Art Screen!

   NOTE: you need a computer with a built in camera or a USB webcam to run the Art Screen examples level 5 and 6







/////////////
    
     The ArtScreen library
     ** webcam required

/////////////

The ArtScreen library
provides the following public variables:

// raw, processing video capture, generally this should not be used
// since it is mirrored, use captureFrame instead
Capture cam; 
	
PImage captureFrame;           // mirrored version of current frame, same resolution as camera
int captureWidth;              // captureFrame width
int captureHeight;             // captureFrame height

// 0 is first valid frame, use this number to track if you have
// already processed the current video frame, since they come in at a different rate than draw frames
// also use this to see if the video camera is setup and ready to analyze
int captureFrameNumber = -1;


See examples for detailed usage

