import artscreen.*;
import processing.video.*;
import largesketchviewer.*;
import com.hamoid.*;

ArtScreen artScreen;

void setup() {
  size(1920, 1080, P2D);
  
  /* NOTE this line will:
   * create a caption, fade-in/out your sketch over 1min, init the webcam
   */
  artScreen = new ArtScreen(this, "“Title” 2017", "by Your Name", "Credits and other optional smaller third line", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
}