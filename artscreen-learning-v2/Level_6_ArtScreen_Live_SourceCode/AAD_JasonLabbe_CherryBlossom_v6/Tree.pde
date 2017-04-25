class Leaf {  
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float diameter;
  float opacity;
  float hue;
  float sat;
  PVector offset;
  boolean dynamic = false;
  Branch parent;

  Leaf(float _x, float _y, Branch _parent) {
    this.pos = new PVector(_x, _y);
    this.diameter = random(2.0, 8.0);
    this.opacity = random(5.0, 50.0);
    this.parent = _parent;
    this.offset = new PVector(_parent.restPos.x-this.pos.x, _parent.restPos.y-this.pos.y);

    if (leaves.size() % 5 == 0) {
      this.hue = 5;
      this.sat = 100;
    } else {
      this.hue = random(75.0, 95.0);
      this.sat = 50;
    }
  }

  void display() {
    noStroke();
    fill(this.hue, sat, 100, this.opacity);
    ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
  }

  void bounds() {
    if (! this.dynamic) {
      return;
    }

    float ground = height-this.diameter*0.5;

    if (this.pos.y > ground) {
      this.vel.y = 0;
      this.vel.x *= 0.95;
      this.pos.y = ground;
    }
  }

  void applyForce(PVector force) {
    this.acc.add(force);
  }

  void move() {
    if (this.dynamic) {
      // Sim leaf

      PVector gravity = new PVector(0, 0.025);
      this.applyForce(gravity);

      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.acc.mult(0);

      this.bounds();
    } else {
      // Follow branch
      this.pos.x = this.parent.end.x+this.offset.x;
      this.pos.y = this.parent.end.y+this.offset.y;
    }
  }

  void destroyIfOutBounds() {
    if (this.dynamic) {
      if (this.pos.x < 0 || this.pos.x > width) {
        leaves.remove(this);
      }
    }
  }
}


class Branch {
  PVector start;
  PVector end;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  int level;
  Branch parent = null;
  PVector restPos;
  float restLength;

  Branch(float _x1, float _y1, float _x2, float _y2, int _level, Branch _parent) {
    this.start = new PVector(_x1, _y1);
    this.end = new PVector(_x2, _y2);
    this.level = _level;
    this.restLength = dist(_x1, _y1, _x2, _y2);
    this.restPos = new PVector(_x2, _y2);
    this.parent = _parent;
  }

  void display() {
    stroke(10, 57, 20+this.level*4);
    strokeWeight(maxLevel-this.level+1);

    if (this.parent != null) {
      line(this.parent.end.x, this.parent.end.y, this.end.x, this.end.y);
    } else {
      line(this.start.x, this.start.y, this.end.x, this.end.y);
    }
  }

  Branch newBranch(float angle, float mult) {
    // Calculate new branch's direction and length
    PVector direction = new PVector(this.end.x, this.end.y);
    direction.sub(this.start);
    float branchLength = direction.mag();

    // Javascript doesn't have PVector.rotate() method
    // so need to manually get its new angle.
    float worldAngle = degrees(atan2(direction.x, direction.y))+angle;
    direction.x = sin(radians(worldAngle));
    direction.y = cos(radians(worldAngle));
    direction.normalize();
    direction.mult(branchLength*mult);

    PVector newEnd = new PVector(this.end.x, this.end.y);
    newEnd.add(direction);

    return new Branch(this.end.x, this.end.y, newEnd.x, newEnd.y, this.level+1, this);
  }

  void applyForce(PVector force) {
    PVector forceCopy = force.get();

    // Smaller branches will be more bouncy
    float divValue = map(this.level, 0, maxLevel, 8.0, 2.0);
    forceCopy.div(divValue);

    this.acc.add(forceCopy);
  }

  void sim() {
    PVector airDrag = new PVector(this.vel.x, this.vel.y);
    float dragMagnitude = airDrag.mag();
    airDrag.normalize();
    airDrag.mult(-1);
    //airDrag.mult(0.025*dragMagnitude*dragMagnitude); // java mode
    airDrag.mult(0.05*dragMagnitude*dragMagnitude); // js mode
    this.applyForce(airDrag);

    PVector spring = new PVector(this.end.x, this.end.y);
    spring.sub(this.restPos);
    float stretchedLength = dist(this.restPos.x, this.restPos.y, this.end.x, this.end.y);
    spring.normalize();
    //float elasticMult = map(this.level, 0, maxLevel, 0.05, 0.1); // java mode
    float elasticMult = map(this.level, 0, maxLevel, 0.1, 0.2); // js mode
    spring.mult(-elasticMult*stretchedLength);
    this.applyForce(spring);
  }

  void move() {
    this.sim();

    this.vel.mult(0.95);

    // Kill velocity below this threshold to reduce jittering
    if (this.vel.mag() < 0.05) {
      this.vel.mult(0);
    }

    this.vel.add(this.acc);
    this.end.add(this.vel);
    this.acc.mult(0);
  }
}


void subDivide(Branch branch) {
  ArrayList<Branch> newBranches = new ArrayList<Branch>();

  int newBranchCount = (int)random(1, 4);

  float minLength = 0.7;
  float maxLength = 0.85;

  switch(newBranchCount) {
  case 2:
    newBranches.add(branch.newBranch(random(-45.0, -10.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(10.0, 45.0), random(minLength, maxLength)));
    break;
  case 3:
    newBranches.add(branch.newBranch(random(-45.0, -15.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(-10.0, 10.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(15.0, 45.0), random(minLength, maxLength)));
    break;
  default:
    newBranches.add(branch.newBranch(random(-45.0, 45.0), random(minLength, maxLength)));
    break;
  }

  for (Branch newBranch : newBranches) {
    branches.add(newBranch);

    if (newBranch.level < maxLevel) {
      subDivide(newBranch);
    } else {
      // Randomly generate leaves position on last branch
      float offset = 5.0;
      for (int i = 0; i < 5; i++) {
        leaves.add(new Leaf(newBranch.end.x+random(-offset, offset), newBranch.end.y+random(-offset, offset), newBranch));
      }
    }
  }
}


void generateNewTree() {
  branches.clear();
  leaves.clear();

  float rootLength = random(80.0, 150.0);
  branches.add(new Branch(width/2, height, width/2, height-rootLength, 0, null));

  subDivide(branches.get(0));
}

void triggerLeaves(PVector source) {
  float branchDistThreshold = 300*300;
  //float branchDistThreshold = 20;

  for (Branch branch : branches) {
    float distance = distSquared(source.x, source.y, branch.end.x, branch.end.y);
    if (distance > branchDistThreshold) {
      continue;
    }

    PVector explosion = new PVector(branch.end.x, branch.end.y);
    explosion.sub(source);
    explosion.normalize();
    float mult = map(distance, 0, branchDistThreshold, 10.0, 1.0); // java mode
    //float mult = map(distance, 0, branchDistThreshold, 6.0, 1.0); // js mode
    explosion.mult(mult);
    branch.applyForce(explosion);
  }

  float leafDistThreshold = 50*50;
  //float leafDistThreshold = 5;

  for (Leaf leaf : leaves) {
    float distance = distSquared(source.x, source.y, leaf.pos.x, leaf.pos.y);
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

float distSquared(float x1, float y1, float x2, float y2) {
  return (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
}