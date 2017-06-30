/* ScreenGrabs
 *
 * performs video exports of running sketches
 * and captures a screenshot
 */
import com.hamoid.*;

import java.io.File;

public class ScreenCapture {
	private final PApplet p;
	private final int saveFrameAtMillis;
	private final PGraphics pgForSavingScreen;
	private final boolean flipLeftToRight;
	
	private VideoExport videoExport;
	private boolean saved = false;
	private boolean savingVideo = false;
	private boolean savingFrame = false;
	
	public ScreenCapture(ArtScreen artScreen, PApplet p, int duration, boolean flipLeftToRight) {
		this.p = p;
		this.flipLeftToRight = flipLeftToRight;
		
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
			
			if (flipLeftToRight) {
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
			} else {
				pgForSavingScreen.copy(p.getGraphics(), 0, 0, p.width, p.height, 0, 0, pgForSavingScreen.width, pgForSavingScreen.height);
			}
			
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