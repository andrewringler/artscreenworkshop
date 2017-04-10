/*
 * Cherry blossom fractals with dynamics
 * by Jason Labbe
 * 
 * https://www.openprocessing.org/sketch/383911
 * jasonlabbe3d.com
 *
 * Credits: Daniel Shiffman's tree fractal series (https://www.youtube.com/watch?v=fcdNSZ9IzJM)
 *
 * Adapted for Art Screen by Andrew Ringler
 */
ArtScreen artScreen;
ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
int maxLevel = 9;

void setup() {
  size(1920, 1080);  
  artScreen = new ArtScreen(this, "Cherry Blossom v4", "by Jason Labbe", "Credits to Daniel Shiffman. Ported by Andrew Ringler");

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
  if (artScreen.motion.movementDetected) {
    triggerLeaves(artScreen.motion.motionPixelX, artScreen.motion.motionPixelY);
  }
}