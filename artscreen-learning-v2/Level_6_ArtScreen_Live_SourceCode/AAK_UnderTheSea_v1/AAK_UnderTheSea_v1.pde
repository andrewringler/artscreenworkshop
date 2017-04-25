/*
 * Cherry blossom fractals with dynamics
 * by Jason Labbe
 * 
 * https://www.openprocessing.org/sketch/383911
 * jasonlabbe3d.com
 * September 24th, 2016
 *
 * Credits: Daniel Shiffman's tree fractal series (https://www.youtube.com/watch?v=fcdNSZ9IzJM)
 *
 * Adapted for Art Screen by Andrew Ringler
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
int maxLevel = 9;

void setup() {
  size(1920, 1080, P2D);  
  artScreen = new ArtScreen(this, "“Under da Sea” 2017", "by Valentina, Jessica & Carlo", "Credits to Jason Labbe, Daniel Shiffman, Andrew Ringler", color(176, 87, 95), color(255, 255, 255, 1));

  colorMode(HSB, 360, 100, 100);
  generateNewTree();
}

void draw() {
  performMotionDetection();

  if (artScreen.captureFrameNumber < 0) {
    return;
  }

  translate(0, -80);

  background(231, 68, 42);

  for (int i = 0; i < branches.size(); i++) {
    Branch branch = branches.get(i);
    branch.move();
    branch.display();
  }
  for (int i = leaves.size()-1; i > -1; i--) {
    Leaf leaf = leaves.get(i);
    leaf.move();
    leaf.display();
    leaf.destroyIfOutBounds();
  }

  calculateBounds();

  if (movementDetected) {
    for (int i=0; i<2 && i<top100MotionPixels.length; i++) {
      MotionPixel m = top100MotionPixels[i];
      triggerLeaves(new PVector(m.location.x, m.location.y));
    }
  }
}