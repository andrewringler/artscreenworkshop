This Sketch is written in the Processing language.
To run it you need to:

1. Download and install Processing, https://processing.org/
2. Launch Processing and install additional libraries:
    Sketch | Import Library… | Add Library… | Click on library, then Install button
    
    You should install the following libraries:
    Video, OpenCV for Processing, 




The ArtScreen library provides the following public variables:

// raw, processing video capture, generally this should not be used since it is mirrored
// used captureFrame instead
Capture cam; 
	
PImage captureFrame;           // mirrored version of current frame, same resolution as camera
int captureWidth;              // camera width
int captureHeight;             // camera height

// 0 is first valid frame, use this number to track if you have
// already processed the current video frame, since they come in at a different rate than draw frames
// also use this to see if the video camera is setup and ready to analyze
int captureFrameNumber = -1;


See examples folder for detailed usages

