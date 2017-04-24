package artscreen;

import static processing.core.PApplet.constrain;
import static processing.core.PApplet.dist;
import static processing.core.PApplet.round;
import static processing.core.PConstants.RGB;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

public class ComputerVision {
	/*
	 * sqrt(255^2 + 255^2 + 255^2) ~= 442
	 * so 120/442 means we want about a 30% change
	 * in a pixel to count it as a motion pixel
	 */
	private static final float MAX_PIXEL_CHANGE = 442;
	
	private final PApplet p;
	private final ArtScreen artScreen;
	private final PImage previousProcessingFrame; // smaller frame for image processing / previous frame
	private final PImage processingFrame; // smaller frame for image processing
	private final int motionThreshold;
	
	public ComputerVision(ArtScreen artScreen, PApplet p, int captureWidth, int captureHeight, int motionThreshold) {
		this.artScreen = artScreen;
		this.p = p;
		this.motionThreshold = motionThreshold;
		
		previousProcessingFrame = p.createImage(captureWidth / 4, captureHeight / 4, RGB);
		processingFrame = p.createImage(captureWidth / 4, captureHeight / 4, RGB);
	}
	
	public void performCalculations(PImage camMirror) {
		processingFrame.copy(camMirror, 0, 0, camMirror.width, camMirror.height, 0, 0, processingFrame.width, processingFrame.height);
		
		if (artScreen.capturedFrameNumber > 0 /* we need at least two frames for frame differencing */) {
			motionUpdates();
		}
		
		// copy current frame to previous
		previousProcessingFrame.copy(processingFrame, 0, 0, processingFrame.width, processingFrame.height, 0, 0, previousProcessingFrame.width, previousProcessingFrame.height);
		
	}
	
	private void motionUpdates() {
		p.pushStyle();
		p.colorMode(RGB, 255);
		
		processingFrame.loadPixels();
		previousProcessingFrame.loadPixels();
		artScreen.motionImage.loadPixels();
		
		MotionPixels motionPixels = new MotionPixels();
		
		float maxChange = 0;
		boolean newMotion = false;
		int newX = 0;
		int newY = 0;
		for (int x = 0; x < previousProcessingFrame.width; x++) {
			for (int y = 0; y < previousProcessingFrame.height; y++) {
				int loc = x + y * previousProcessingFrame.width; //1D pixel location
				int oldR = round(p.red(previousProcessingFrame.pixels[loc]));
				int oldG = round(p.green(previousProcessingFrame.pixels[loc]));
				int oldB = round(p.blue(previousProcessingFrame.pixels[loc]));
				int newR = round(p.red(processingFrame.pixels[loc]));
				int newG = round(p.green(processingFrame.pixels[loc]));
				int newB = round(p.blue(processingFrame.pixels[loc]));
				
				float change = dist(oldR, oldG, oldB, newR, newG, newB);
				if (change > motionThreshold) {
					if (change > maxChange) {
						newMotion = true;
						newX = x;
						newY = y;
					}
					byte changeB = (byte) constrain((int) (change / MAX_PIXEL_CHANGE * 255f), 0, 255);
					artScreen.motionImage.pixels[loc] = p.color((int) changeB);
					PVector newXYProcessingCoordinates = new PVector(x, y);
					motionPixels.add(new MotionPixel(artScreen.toScreenCoordinates(newXYProcessingCoordinates, previousProcessingFrame.width, previousProcessingFrame.height), changeB));
				} else {
					artScreen.motionImage.pixels[loc] = p.color(0);
				}
			}
		}
		artScreen.motionImage.updatePixels();
		
		artScreen.top100MotionPixels = motionPixels.toArray();
		
		artScreen.movementDetected = newMotion;
		PVector motionPixel = new PVector(newX, newY);
		artScreen.maxMotionLocation = artScreen.toScreenCoordinates(motionPixel, previousProcessingFrame.width, previousProcessingFrame.height);
		
		p.popStyle();
	}
}
