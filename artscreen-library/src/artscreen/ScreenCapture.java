package artscreen;

import static processing.core.PApplet.day;
import static processing.core.PApplet.hour;
import static processing.core.PApplet.minute;
import static processing.core.PApplet.month;
import static processing.core.PApplet.second;
import static processing.core.PApplet.year;

import java.io.File;

import com.hamoid.VideoExport;

import processing.core.PApplet;
import processing.core.PGraphics;

public class ScreenCapture {
	private final PApplet p;
	private final int saveFrameAtMillis;
	private final PGraphics pgForSavingScreen;
	
	private VideoExport videoExport;
	private boolean saved = false;
	private boolean savingVideo = false;
	private boolean savingFrame = false;
	
	public ScreenCapture(ArtScreen artScreen, PApplet p, int duration) {
		this.p = p;
		
		/* for saving frames, for documentation */
		saveFrameAtMillis = (int) (duration / 2.0); // safe frame mid-way through our run
		pgForSavingScreen = p.createGraphics(p.width, p.height);
		
		if (artScreen.settings.containsKey("saveframe")) {
			savingFrame = true;
		}
		
		// export as video
		if (artScreen.settings.containsKey("savevideo")) {
			savingVideo = true;
			
			new File(p.sketchPath("saved")).mkdir();
			videoExport = new VideoExport(p);
			videoExport.setQuality(70, 128);
			videoExport.setFrameRate(30);
			videoExport.setMovieFileName("saved/" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + getClass().getSimpleName() + ".mp4");
			videoExport.setDebugging(false);
			videoExport.startMovie();
		}
	}
	
	public void checkSave() {
		if (savingFrame || savingVideo) {
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
			pgForSavingScreen.endDraw();
		}
		
		// only save PNG frame once 
		if (savingFrame && !saved && p.millis() > saveFrameAtMillis) {
			saved = true;
			pgForSavingScreen.save("saved/" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + getClass().getSimpleName() + ".png");
		}
		
		if (savingVideo) {
			videoExport.setGraphics(pgForSavingScreen);
			videoExport.saveFrame();
		}
	}
	
	public void endMovie() {
		if (savingVideo) {
			videoExport.endMovie();
			savingVideo = false;
		}
	}
}
