import artscreen.*;
import largesketchviewer.*;
import processing.video.*;

ArtScreen artScreen;
void setup() {
  size(1920, 1080, P2D);
  artScreen = new ArtScreen(this, "“posterize” 2017", "by Andrea & Anna", "", color(255), color(0, 1));
}

int x = 0;

void draw() {
  image(artScreen.captureFrame, 0, 0, width, height);
  filter(POSTERIZE, 4);
  x += 1;
  if (x%10 == 0) {
    filter(INVERT);
  }
}