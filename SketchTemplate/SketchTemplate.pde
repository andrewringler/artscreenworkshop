/*
 * Title
 * by Yourname
 * 
 * Credits:
 * anyone you took code from and need to credit
 * and the URLs of that code
 */
ArtScreen artScreen;

void setup() {
  size(1920, 1080);  
  artScreen = new ArtScreen(this, "Title", "by Your Name", "Credits and other optional smaller third line", color(0, 0, 0), color(255, 255, 255));
}

void draw() {
  background(100);

  textSize(40);
  textAlign(CENTER, CENTER);
  text("Hello", width/2, height/2);
}