package artscreen;

import static processing.core.PConstants.RGB;

import processing.core.PApplet;

public class Debug {
	private ArtScreen artScreen;
	private PApplet p;
	public boolean debug = false;
	
	public Debug(ArtScreen artScreen, PApplet p) {
		this.artScreen = artScreen;
		this.p = p;
	}
	
	public void drawDebugInfo() {
		if (debug) {
			p.pushStyle();
			p.pushMatrix();
			p.resetMatrix();
			p.colorMode(RGB, 255);
			p.noStroke();
			p.fill(255);
			// draw change amount at every motion pixel
			for (MotionPixel motionPixel : artScreen.top100MotionPixels) {
				p.text(motionPixel.changeAmount, motionPixel.location.x, motionPixel.location.y);
			}
			p.popMatrix();
			p.popStyle();
		}
	}
	
	public void toggleOn() {
		debug = !debug;
	}
}
