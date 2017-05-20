package artscreen;

import static processing.core.PApplet.println;
import static processing.core.PConstants.RGB;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import largesketchviewer.LargeSketchViewer;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;
// https://processing.org/reference/libraries/video/Capture.html
import processing.video.Capture;

/**
 * ArtScreen is required to publish your art to
 * the interactive screen.
 * 
 * @example Empty
 */
public class ArtScreen {
	public static final String VERSION = "##library.prettyVersion##";
	private static final int DEFAULT_DURATION = 60 * 1000;
	private static final int FADE_BLACK_MILLIS = 750;
	
	private final PApplet p;
	
	private final ScreenCapture screenCapture;
	private final Text text;
	
	private final String titleOfArtwork, artistFullName, additionalCredits;
	private final int captionTextColor, captionBackgroundColor;
	
	private final int duration;
	private int timeOfFirstDrawMillis = 0;
	
	// Video Processing
	private static final int DEFAULT_CAPTURE_WIDTH = 1280;
	private static final int DEFAULT_CAPTURE_HEIGHT = 720;
	private static final float DEFAULT_CAPTURE_FPS = 30;
	
	private final Pattern processingCaptureWidthHeightMatcher = Pattern.compile(".*size=([0-9]+)x([0-9]+),.*");
	
	public Capture cam; // processing video capture
	public PImage captureFrame;
	public int captureWidth;
	public int captureHeight;
	public int captureFrameNumber = -1;
	public final Properties settings = new Properties();
	
	public ArtScreen(PApplet p, String titleOfArtwork, String artistFullName, String additionalCredits, int captionTextColor, int captionBackgroundColor) {
		this.p = p;
		this.titleOfArtwork = titleOfArtwork;
		this.artistFullName = artistFullName;
		this.additionalCredits = additionalCredits;
		this.captionTextColor = captionTextColor;
		this.captionBackgroundColor = captionBackgroundColor;
		
		try {
			settings.load(new FileInputStream(p.sketchFile("data/artscreen-settings.txt")));
		} catch (IOException e) {
			// ignore
		}
		
		duration = getDuration(p);
		text = new Text(p);
		screenCapture = new ScreenCapture(this, p, duration);
		
		String[] availableCameras = Capture.list();
		if (availableCameras.length == 0) {
			println("No cameras found. Exiting.");
			p.exit();
			return;
		}
		
		String requestedCamera = availableCameras[0];
		String partialCameraName = "size=" + DEFAULT_CAPTURE_WIDTH + "x" + DEFAULT_CAPTURE_HEIGHT + ",fps=" + DEFAULT_CAPTURE_FPS;
		for (String camera : availableCameras) {
			if (camera.contains(partialCameraName)) {
				requestedCamera = camera;
				break;
			}
		}
		cam = new Capture(p, requestedCamera);
		cam.start(); // if on processing 151, comment this line 
		
		Matcher matcher = processingCaptureWidthHeightMatcher.matcher(requestedCamera);
		if (!matcher.matches()) {
			throw new IllegalStateException("Unable to initialize camera");
		}
		captureWidth = Integer.valueOf(matcher.group(1));
		captureHeight = Integer.valueOf(matcher.group(2));
		
		captureFrame = p.createImage(captureWidth, captureHeight, RGB);
		
		if (p.args != null && p.args.length != 0 && p.args[0].equals("nopreview")) {
			// no preview
		} else {
			LargeSketchViewer.smallPreview(p, false, 15, true); // show smaller preview
		}
		
		// draw black background
		p.pushStyle();
		p.colorMode(RGB, 255);
		p.background(0);
		p.popStyle();
		
		p.noCursor(); // remove cursor icon
		
		// speed up OpenGL and disable spurious messages
		// http://processingjs.org/reference/hint_/
		p.hint(PConstants.DISABLE_OPENGL_ERRORS);
		
		p.registerMethod("pre", this);
		p.registerMethod("draw", this);
		p.registerMethod("post", this);
		p.registerMethod("dispose", this);
	}
	
	// Method that's called just after beginDraw(), meaning that it can affect drawing.
	public void pre() {
		if (p.millis() >= duration) {
			// enough time has passed, exit Sketch
			// so the next Sketch may start
			screenCapture.endMovie();
			p.exit();
		}
		
		if (cam.available() == true) {
			cam.read();
			
			// flip all pixels left-to-right, so our webcam behaves like a mirror, instead of a camera
			cam.loadPixels();
			captureFrame.loadPixels();
			for (int x = 0; x < cam.width; x++) {
				for (int y = 0; y < cam.height; y++) {
					int yOffset = y * cam.width;
					int srcLoc = x + yOffset;
					int destLoc = (cam.width - x - 1) + yOffset;
					captureFrame.pixels[destLoc] = cam.pixels[srcLoc];
				}
			}
			captureFrame.updatePixels();
			
			captureFrameNumber++; // a new frame is available			
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
		p.pushStyle();
		p.pushMatrix();
		if (p.sketchRenderer() == PApplet.P3D) {
			p.camera(); // https://github.com/processing/processing/issues/2128
		} else {
			p.resetMatrix();
		}
		p.colorMode(RGB, 255);
		p.translate(p.width, 0);
		p.scale(-1, 1);
		
		// ensure we clobber the screen even in P3D mode
		// http://processingjs.org/reference/hint_/
		p.hint(PApplet.DISABLE_DEPTH_TEST);
		
		text.drawArtworkCaption(titleOfArtwork, artistFullName, additionalCredits, captionTextColor, captionBackgroundColor);
		
		if (timeOfFirstDrawMillis == 0) {
			timeOfFirstDrawMillis = p.millis();
		}
		
		// fade from black, as sketch is launching
		int timeSinceFirstDrawMillis = p.millis() - timeOfFirstDrawMillis;
		if (timeSinceFirstDrawMillis <= FADE_BLACK_MILLIS) {
			black(1f - ((float) timeSinceFirstDrawMillis / (float) FADE_BLACK_MILLIS));
		}
		
		// fade to black as sketch is quitting
		int timeToQuit = duration - p.millis();
		if (timeToQuit <= FADE_BLACK_MILLIS) {
			black(1f - ((float) timeToQuit / (float) FADE_BLACK_MILLIS));
		}
		
		p.hint(PApplet.ENABLE_DEPTH_TEST);
		p.popMatrix();
		p.popStyle();
	}
	
	// Method called after draw has completed and the frame is done. No drawing allowed.
	public void post() {
		screenCapture.checkSave();
	}
	
	// Anything in here will be called automatically when 
	// the parent sketch shuts down.
	public void dispose() {
		cam.stop();
		cam = null;
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
	
	private void black(float opacity) {
		p.noStroke();
		p.rectMode(PApplet.CORNER);
		p.fill(0, 0, 0, (int) PApplet.round(opacity * 255f));
		p.rect(0, 0, p.width, p.height);
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
