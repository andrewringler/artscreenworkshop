/* create 'webby' numbers and letters
 * by Jerome Herr
 * https://www.openprocessing.org/sketch/149337
 * May 22nd, 2014
 * Creative Commons Attribution ShareAlike
 *
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
String l = "Hello!"; 
int fc, num = 2000*l.length();
ArrayList ballCollection; 
boolean save = false;
float scal, theta;
PGraphics letter;
PFont font;
int fontSize = 400;
float originX, originY;

void setup() {
  size(1920, 1080, P2D);  
  artScreen = new ArtScreen(this, "“webby” 2014", "by Jerome Herr", "Adapted for Art Screen by Andrew Ringler", color(255), color(20));

  background(20);
  letter = createGraphics(int(fontSize*l.length()), fontSize);
  font = loadFont("Arial-Black-250.vlw");
  ballCollection = new ArrayList();
  createStuff();

  originX = width / 2 - letter.width/2;
  originY =  height / 2 - letter.height/2;
}

void draw() {
  background(20);
  translate(originX, originY);

  for (int i=0; i<ballCollection.size (); i++) {
    Ball mb = (Ball) ballCollection.get(i);
    mb.run();
  }  

  theta += .0523;
}

void createStuff() {
  ballCollection.clear();

  letter.beginDraw();
  letter.noStroke();
  letter.background(255);
  letter.fill(0);
  letter.textFont(font, fontSize);
  letter.textAlign(CENTER);
  letter.text(l, l.length() * fontSize / 2, 350.0/400.0 * fontSize);
  letter.endDraw();
  letter.loadPixels();

  // sample random points on the letter
  // to find locations to place our balls
  for (int i=0; i<num; i++) {
    int x = (int)random(letter.width);
    int y = (int)random(letter.height);
    //color c = letter.get(x, y);
    int c = letter.pixels[x+y*letter.width];
    if (brightness(c)<255) {
      PVector org = new PVector(x, y);
      float radius = random(5, 10);
      PVector loc = new PVector(org.x+radius, org.y);
      float offSet = random(TWO_PI);
      int dir = 1;
      float r = random(1);
      if (r>.5) dir =-1;
      Ball myBall = new Ball(org, loc, radius, dir, offSet);
      ballCollection.add(myBall);
    }
  }
}

class Ball {
  PVector org, loc;
  float sz = 2;
  float radius, offSet, a;
  int s, dir, countC, d = 20;
  boolean[] connection = new boolean[num];

  Ball(PVector _org, PVector _loc, float _radius, int _dir, float _offSet) {
    org = _org;
    loc = _loc;
    radius = _radius;
    dir = _dir;
    offSet = _offSet;
  }

  void run() {
    display();
    move();
    lineBetween();
  }

  void move() {
    loc.x = org.x + sin(theta*dir+offSet)*radius;
    loc.y = org.y + cos(theta*dir+offSet)*radius;
  }

  void lineBetween() {
    countC = 1;
    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.dist(other.loc);
      if (distance >0 && distance < d) {
        a = map(countC, 0, 10, 10, 255);
        stroke(255, a);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
        connection[i] = true;
      } else {
        connection[i] = false;
      }
    }
    for (int i=0; i<ballCollection.size(); i++) {
      if (connection[i]) countC++;
    }
  }

  void display() {
    noStroke();
    fill(255, 200);
    ellipse(loc.x, loc.y, sz, sz);
  }
}