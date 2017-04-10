/*

 Camera deform js
 by
 oggy (https://www.openprocessing.org/user/32527)
 January 6th, 2015
 
 A fork of Using camera with processing.js by Makio135.
 move the mouse: deform the image
 click/unclick: repulse/attract the points
 
 https://www.openprocessing.org/sketch/180047
 
 adapted for Art Screen by Andrew Ringler
 
 Licence: Creative Commons Attribution ShareAlike
 */
ArtScreen artScreen;
MyPoint[] pts;
PImage img;
int nbW = 50, nbH = 25;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "Camera Deform", "by Oggy", "Fork of using Camera by Makio135. Adapted for Art Screen by Andrew Ringler", color(255, 255, 255), color(0, 0, 0));

  initialize();
  stroke(0, 80);
}

void initialize() {
  pts = new MyPoint[nbW*nbH];
  for (int j=0; j<nbH; j++) {
    for (int i=0; i<nbW; i++) {
      pts[i + j*nbW] = new MyPoint(new PVector(i * width/nbW, j * height/nbH));
    }
  }
}

void draw() {
  image(artScreen.video, 0, 0, width, height);

  img = get();
  img.resize(nbW, nbH);
  background(255);

  beginShape(TRIANGLES);
  //beginShape(QUAD);
  //texture(img);
  PVector a, b, c, d;
  float x1, x2, y1, y2;
  for (int j=0; j<nbH; j++) {
    for (int i=0; i<nbW; i++) {
      if (j<nbH-1 && i<nbW-1) 
      {           
        a = pts[i + j*nbW].pos;
        b = pts[i+1 + j*nbW].pos;
        c = pts[i+1 + (j+1)*nbW].pos;
        d = pts[i + (j+1)*nbW].pos;

        x1 = (a.x + b.x + d.x) / 3;
        x2 = (b.x + c.x + d.x) / 3;
        y1 = (a.y + b.y + d.y) / 3;
        y2 = (b.y + c.y + d.y) / 3;

        fill(img.get(int(x1/width*nbW), int(y1/height*nbH)));
        vertex(a.x, a.y);
        vertex(b.x, b.y);
        vertex(d.x, d.y);

        fill(img.get(int(x2/width*nbW), int(y2/height*nbH)));
        vertex(b.x, b.y);
        vertex(c.x, c.y);
        vertex(d.x, d.y);
      }
      pts[i + j*nbW].process();
    }
  }
  endShape();
}

class MyPoint {
  final static float MAX_DIST_MOUSE = 180;//mouse influence zone
  final static float FRICTION_AIR = .092;//'air' FRICTION_AIR
  PVector target;//original position, MyPoint always tries to get back to it
  PVector f = new PVector(0, 0);//force applied to the point
  PVector pos, tmpv;
  int countExclude;

  MyPoint(PVector p_p) {
    pos = p_p;
    target = pos.get();
  }

  void process() {
    f.mult(FRICTION_AIR);   

    // Warp Pixels near movement
    if (artScreen.motion.movementDetected) {
      float d = dist(pos.x, pos.y, artScreen.motion.motionPixelX, artScreen.motion.motionPixelY);
      if (d < 6) d = 6;//prevent erratic behavior

      if (d < MAX_DIST_MOUSE)//mouse effect
      {
        tmpv = new PVector(artScreen.motion.motionPixelX, artScreen.motion.motionPixelY);
        tmpv.sub(pos);
        float a = 0.83 * cos(map(d, 0, MAX_DIST_MOUSE, 0, HALF_PI));
        //tmpv.mult((mousePressed ? -1 : 1) * a / d);
        tmpv.mult(a / d);
        f.add(tmpv);
      }
    }

    //attracted to its original position
    tmpv = target.get();
    tmpv.sub(pos);
    //tmpv.mult(.03);
    tmpv.mult(.003);
    f.add(tmpv);    
    pos.add(f);
  }
}