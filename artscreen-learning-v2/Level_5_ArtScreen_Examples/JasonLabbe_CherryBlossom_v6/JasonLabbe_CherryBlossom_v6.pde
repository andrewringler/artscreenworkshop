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
import gab.opencv.*;

ArtScreen artScreen;
ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
int maxLevel = 9;

void setup() {
  size(1920, 1080, P3D);  
  artScreen = new ArtScreen(this, "Cherry Blossom v6, 2016", "by Jason Labbe", "Credits to Daniel Shiffman. Adapted for Screen by Andrew Ringler", color(0, 0, 0), color(255, 255, 255));

  colorMode(HSB, 100);
  generateNewTree();
}

void draw() {
  background(100);

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

  if (artScreen.movementDetected) {
    for (int i=0; i<2 && i<artScreen.top100MotionPixels.length; i++) {
      MotionPixel m = artScreen.top100MotionPixels[i];
      triggerLeaves(new PVector(m.location.x, m.location.y));
    }
  }

  //if (artScreen.movementDetected) {
  //  triggerLeaves(artScreen.maxMotionLocation);
  //}
}