package artscreen;

import static processing.core.PApplet.day;
import static processing.core.PApplet.hour;
import static processing.core.PApplet.minute;
import static processing.core.PApplet.month;
import static processing.core.PApplet.second;
import static processing.core.PApplet.year;

import processing.core.PApplet;
import processing.core.PGraphics;

public class ScreenCapture {
	private final PApplet p;
	private final int saveFrameAtMillis;
	private final PGraphics pgForSavingScreen;
	
	private boolean saved = false;
	
	public ScreenCapture(ArtScreen artScreen, PApplet p, int duration) {
		this.p = p;
		
		/* for saving frames, for documentation */
		saveFrameAtMillis = (int) (duration / 2.0); // safe frame mid-way through our run
		pgForSavingScreen = p.createGraphics(p.width, p.height);
		
	}
	
	public void checkSave() {
		if (!saved && p.millis() > saveFrameAtMillis) {
			saved = true;
			pgForSavingScreen.beginDraw();
			pgForSavingScreen.loadPixels();
			p.loadPixels();
			for (int x = 0; x < p.width; x++) {
				for (int y = 0; y < p.height; y++) {
					/*
					 * copy current display to our staging graphics
					 * mirroring the image in the process
					 * https://processing.org/discourse/beta/num_1220788246.html
					 */
					pgForSavingScreen.pixels[y * p.width + x] = p.pixels[(p.width - x - 1) + y * p.width]; // Reversing x to mirror the image
				}
			}
			
			pgForSavingScreen.updatePixels();
			pgForSavingScreen.save("saved/" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + getClass().getSimpleName() + ".png");
			pgForSavingScreen.endDraw();
		}
	}
	
}
