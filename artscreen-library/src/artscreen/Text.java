package artscreen;

import static processing.core.PConstants.RGB;
import static processing.core.PConstants.RIGHT;
import static processing.core.PConstants.TOP;

import processing.core.PApplet;
import processing.core.PFont;

public class Text {
	private final PApplet p;
	
	public final PFont openSansSemiBold22;
	public final PFont openSansSemiBoldItalic22;
	public final PFont openSansSemiBold16;
	
	// Captions
	private static final int CAPTION_HEIGHT = 80;
	private static final int CAPTION_MARGIN_RIGHT = 30;
	private static final int CAPTION_MARGIN_TOP = 8;
	private static final int CAPTION_LINE_HEIGHT = 24;
	private static final int CAPTION_Y_OFFSET = 0;
	
	public Text(PApplet p) {
		this.p = p;
		openSansSemiBold22 = p.loadFont("OpenSans-Semibold-22.vlw");
		openSansSemiBoldItalic22 = p.loadFont("OpenSans-SemiboldItalic-22.vlw");
		openSansSemiBold16 = p.loadFont("OpenSans-Semibold-16.vlw");
	}
	
	public void drawArtworkCaption(String titleOfArtwork, String artistFullName, String additionalCredits, int captionTextColor, int captionBackgroundColor) {
		float yTop = p.height - CAPTION_HEIGHT - CAPTION_Y_OFFSET;
		float captionTop = yTop + CAPTION_MARGIN_TOP;
		
		p.pushStyle();
		p.pushMatrix();
		if (p.sketchRenderer() == PApplet.P3D) {
			// Use camera to reset the transform when using P3D
			// https://github.com/processing/processing/issues/2128
			p.camera();
		} else {
			p.resetMatrix();
		}
		p.colorMode(RGB, 255);
		p.translate(p.width, 0);
		p.scale(-1, 1);
		p.noStroke();
		p.fill(captionBackgroundColor);
		p.rect(p.width * 2f / 3f, yTop, p.width / 3f, CAPTION_HEIGHT);
		
		p.fill(captionTextColor);
		p.textAlign(RIGHT, TOP);
		p.textFont(openSansSemiBoldItalic22);
		p.text(titleOfArtwork, p.width - CAPTION_MARGIN_RIGHT, captionTop);
		p.textFont(openSansSemiBold22);
		p.text(artistFullName, p.width - CAPTION_MARGIN_RIGHT, captionTop + CAPTION_LINE_HEIGHT);
		p.textFont(openSansSemiBold16);
		p.text(additionalCredits, p.width - CAPTION_MARGIN_RIGHT, captionTop + 2 * CAPTION_LINE_HEIGHT);
		p.popMatrix();
		p.popStyle();
	}
}
