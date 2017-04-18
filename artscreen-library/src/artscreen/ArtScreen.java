package artscreen;

import static processing.core.PApplet.constrain;
import static processing.core.PApplet.round;
import static processing.core.PConstants.RGB;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;
import processing.event.KeyEvent;

/**
 * ArtScreen is required to publish your art to
 * the interactive screen.
 * 
 * @example Empty
 */
public class ArtScreen {
	public static final String VERSION = "##library.prettyVersion##";
	private static final int DEFAULT_DURATION = 60 * 1000;
	
	private final PApplet p;
	
	final ScreenCapture screenCapture;
	final Text text;
	final Debug debug;
	
	private final String titleOfArtwork, artistFullName, additionalCredits;
	private final int captionTextColor, captionBackgroundColor;
	
	private final int duration;
	
	// Video Processing
	private final PImage camSmall;
	private final PImage camSmallMirror;
	public static final int DEFAULT_CAPTURE_WIDTH = 1280;
	public static final int DEFAULT_CAPTURE_HEIGHT = 720;
	
	public static final int IMG_PROCESSING_W = DEFAULT_CAPTURE_WIDTH / 2;
	public static final int IMG_PROCESSING_H = DEFAULT_CAPTURE_HEIGHT / 2;
	
	private final float screenToCaptureRatioWidth, screenToCaptureRatioHeight;
	
	// Public variables sketches should access
	public Face[] faces = new Face[] {}; // initially empty, no faces
	public PImage motionImage;
	public boolean movementDetected = false;
	public PVector maxMotionLocation = new PVector(0, 0);
	public MotionPixel[] top100MotionPixels = new MotionPixel[] {};
	
	public ArtScreen(PApplet p, String titleOfArtwork, String artistFullName, String additionalCredits, int captionTextColor, int captionBackgroundColor) {
		this.p = p;
		this.titleOfArtwork = titleOfArtwork;
		this.artistFullName = artistFullName;
		this.additionalCredits = additionalCredits;
		this.captionTextColor = captionTextColor;
		this.captionBackgroundColor = captionBackgroundColor;
		
		duration = getDuration(p);
		
		camSmall = p.createImage(DEFAULT_CAPTURE_WIDTH / 4, DEFAULT_CAPTURE_HEIGHT / 4, RGB);
		camSmallMirror = p.createImage(DEFAULT_CAPTURE_WIDTH / 4, DEFAULT_CAPTURE_HEIGHT / 4, RGB);
		
		screenCapture = new ScreenCapture(this, p, duration);
		text = new Text(p);
		debug = new Debug(this, p);
		
		screenToCaptureRatioWidth = p.width / (float) DEFAULT_CAPTURE_WIDTH;
		screenToCaptureRatioHeight = p.height / (float) DEFAULT_CAPTURE_HEIGHT;
		
		motionImage = p.createImage(DEFAULT_CAPTURE_WIDTH / 4, DEFAULT_CAPTURE_HEIGHT / 4, RGB);
		
		// draw black background
		p.pushStyle();
		p.colorMode(RGB, 255);
		p.background(0);
		p.popStyle();
		
		// draw our caption right away, before the sketch has loaded
		text.drawArtworkCaption(titleOfArtwork, artistFullName, additionalCredits, captionTextColor, captionBackgroundColor);
		
		p.noCursor(); // remove cursor icon
		
		p.registerMethod("pre", this);
		p.registerMethod("draw", this);
		p.registerMethod("post", this);
		p.registerMethod("keyEvent", this);
	}
	
	public void update(PImage cam) {
		camSmall.copy(cam, 0, 0, cam.width, cam.height, 0, 0, camSmall.width, camSmall.height);
		
		// flip all pixels left-to-right, so our webcam behaves like a mirror, instead of a camera
		// http://stackoverflow.com/questions/29334348/processing-mirror-image-over-x-axis
		camSmall.loadPixels();
		camSmallMirror.loadPixels();
		for (int i = 0; i < camSmallMirror.pixels.length; i++) { //loop through each pixel
			int srcX = i % camSmallMirror.width; //calculate source(original) x position
			int dstX = camSmallMirror.width - srcX - 1; //calculate destination(flipped) x position = (maximum-x-1)
			int y = i / camSmallMirror.width; //calculate y coordinate
			camSmallMirror.pixels[y * camSmallMirror.width + dstX] = camSmall.pixels[i];//write the destination(x flipped) pixel based on the current pixel  
		}
		camSmallMirror.updatePixels();
	}
	
	// Method that's called just after beginDraw(), meaning that it can affect drawing.
	public void pre() {
		if (p.millis() >= duration) {
			// enough time has passed, exit Sketch
			// so the next Sketch may start
			p.exit();
		}
		
		/*
		 * since we are rear-projecting our image will be
		 * mirrored, so we want to flip it, so text reads correctly
		 * and so that the user's motion is as expected
		 */
		p.scale(-1, 1);
		p.translate(-p.width, 0);
	}
	
	// Method that's called at the end of draw(), but before endDraw().
	public void draw() {
		debug.drawDebugInfo();
		text.drawArtworkCaption(titleOfArtwork, artistFullName, additionalCredits, captionTextColor, captionBackgroundColor);
	}
	
	// Called when a key event occurs in the parent applet. 
	// Drawing is allowed because key events are queued, unless the sketch has called noLoop().
	public void keyEvent(KeyEvent e) {
		switch (e.getAction()) {
			case KeyEvent.RELEASE:
				debug.toggleOn();
				break;
		}
	}
	
	// Method called after draw has completed and the frame is done. No drawing allowed.
	public void post() {
		screenCapture.checkSave();
	}
	
	public float cameraXToScreen(float x) {
		return constrain((float) x * screenToCaptureRatioWidth, 0, p.width);
	}
	
	public float cameraYToScreen(float y) {
		return constrain((float) y * screenToCaptureRatioHeight, 0, p.height);
	}
	
	public PVector toScreenCoordinates(PVector pv, int srcWidth, int srcHeight) {
		float newX = constrain(round((float) pv.x * (float) p.width / (float) (srcWidth)), 0, p.width);
		float newY = constrain(round((float) pv.y * (float) p.height / (float) (srcHeight)), 0, p.height);
		
		return new PVector(newX, newY);
	}
	
	private int getDuration(PApplet p) {
		if (p.args != null && p.args.length >= 2) {
			try {
				int requestedDuration = Integer.parseInt(p.args[1]);
				if (requestedDuration > 1000) {
					return requestedDuration;
				}
			} catch (NumberFormatException e) {
				// ignore
			}
		}
		return DEFAULT_DURATION;
	}
	
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}
}
