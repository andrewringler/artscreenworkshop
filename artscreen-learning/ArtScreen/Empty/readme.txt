This Sketch is written in the Processing language.
To run it you need to:

1. Download and install Processing, https://processing.org/
2. Launch Processing and install additional libraries:
    Sketch | Import Library… | Add Library… | Click on library, then Install button
    
    You should install the following libraries:
    Video, OpenCV for Processing, 




The ArtScreen library provides the following public variables:

Face[] faces = new Face[] {}; // initially empty, no faces
	A face has location, width and height:

	class Face {
		PVector location;
		float width;
		float height;
	}

PImage motionImage;
boolean movementDetected = false;
PVector maxMotionLocation = new PVector(0, 0);
MotionPixel[] top100MotionPixels = new MotionPixel[] {};
	A motion pixel has location and changeAmount

	class MotionPixel {
		PVector location;
		byte changeAmount;
	}

PImage camSmall;
PImage camSmallMirror;
Capture cam; // processing video capture
int captureWidth;
int captureHeight;

// convert smaller camera images to screen coordinates
cameraXToScreen(float x, float srcWidth)
cameraYToScreen(float y, float srcHeight)



All the variables can be accessed via the artScreen object you created, like:

artScreen.faces
artScreen.motionImage

etc…

See examples folder for detailed usages

