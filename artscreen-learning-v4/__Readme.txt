/////////////
   
    Getting Started

/////////////
These are all Sketches written in the Processing language.
To run them you need to:

1. Download and install Processing, https://processing.org/
2. Launch Processing and install additional libraries:
    Sketch | Import Library… | Add Library… | Click on library, then Install button
    
    Install the following libraries:
    Video, OpenCV for Processing, BoofCV for Processing, PixelFlow, Video Export


** Check out examples from Level 1-4 to learn the Processing Language
   double-click the .pde file to launch Processing

** or if you are familiar with Processing already
   just jump straight to Level 5 or 6 Art Screen Examples
   to see how you can create new interactive content for the Art Screen!

   NOTE: you need a computer with a built in camera or a USB webcam to run the Art Screen examples level 5 and 6







   
/////////////
   
    Processing Resources

/////////////
Processing official website
processing.org
Tutorials, Examples, Reference

Abe Pazos Fun Programming
funprogramming.org

Daniel Shiffman Learning Processing Videos
https://www.youtube.com/user/shiffman/playlists?shelf_id=2&view=50&sort=dd









/////////////
    
     The ArtScreen library
     ** webcam required

/////////////

The ArtScreen library
provides the following public variables:

// raw, processing video capture, generally you have no reason to use this
// since it will be flipped incorrectly left-to-right, use captureFrame instead
Capture cam
	
PImage captureFrame           // mirrored version of current frame, same resolution as camera
int captureWidth              // captureFrame width
int captureHeight             // captureFrame height

// 0 is first valid frame, use this number to track if you have
// already processed the current video frame, since they come in at a different rates than draw frames do
// also use this to see if the video camera is setup and ready to analyze
int captureFrameNumber


See examples level 5 and 6 for detailed usage
