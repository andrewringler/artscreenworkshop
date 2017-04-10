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
ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
int maxLevel = 9;

void setup() {
  size(1920, 1080);  
  colorMode(HSB, 100);

  generateNewTree();

  initializeArtScreen();
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
  if (motion.movementDetected) {
    triggerLeaves(motion.motionPixelX, motion.motionPixelY);
  }

  drawArtworkCaption("Cherry Blossom", "by Jason Labbe", "Credits to Daniel Shiffman. Ported by Andrew Ringler");
}



void mousePressed() {
  generateNewTree();
}

void keyPressed() {
  PVector source = new PVector(mouseX, mouseY);

  float branchDistThreshold = 300*300;

  for (Branch branch : branches) {
    float distance = distSquared(mouseX, mouseY, branch.end.x, branch.end.y);
    if (distance > branchDistThreshold) {
      continue;
    }

    PVector explosion = new PVector(branch.end.x, branch.end.y);
    explosion.sub(source);
    explosion.normalize();
    //float mult = map(distance, 0, branchDistThreshold, 10.0, 1.0); // java mode
    float mult = map(distance, 0, branchDistThreshold, 6.0, 1.0); // js mode
    explosion.mult(mult);
    branch.applyForce(explosion);
  }

  float leafDistThreshold = 50*50;

  for (Leaf leaf : leaves) {
    float distance = distSquared(mouseX, mouseY, leaf.pos.x, leaf.pos.y);
    if (distance > leafDistThreshold) {
      continue;
    }

    PVector explosion = new PVector(leaf.pos.x, leaf.pos.y);
    explosion.sub(source);
    explosion.normalize();
    float mult = map(distance, 0, leafDistThreshold, 2.0, 0.1);
    mult *= random(0.8, 1.2); // Explosion looks too spherical otherwise, this helps give it variation
    explosion.mult(mult);
    leaf.applyForce(explosion);

    leaf.dynamic = true;
  }
}