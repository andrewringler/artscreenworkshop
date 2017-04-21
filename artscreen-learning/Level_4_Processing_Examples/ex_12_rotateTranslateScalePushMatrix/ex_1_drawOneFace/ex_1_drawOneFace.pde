/* Draw a face */
void setup() {
  size(600, 600);
  background(0);
  ellipseMode(CENTER);
  
  drawFace();
}

void drawFace() {
  // head
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(width/2, height/2, 450, 450);
  
  // eyes
  ellipse(width/2-450*0.24, height/2-450*0.1, 46, 40); // left
  ellipse(width/2+450*0.24, height/2-450*0.1, 46, 40); // right
  
  // nose
  ellipse(width/2, height/2+10, 30, 32);
    
  // mouth
  ellipse(width/2, height/2+450*0.3, 80, 80);
}