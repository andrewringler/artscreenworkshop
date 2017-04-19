void setup() {
  /* try changing the size here,
   * the circles will stay centered */
  size(600, 300);
  background(255);
  noStroke();
  fill(129, 242, 95, 80);

  float centerX = width/2.0;
  float centerY = height/2.0;
  
  /* change the size value here, the circles
   * will still stay in relative size proportions to
   * each-other */
  float size = 40;

  ellipse(centerX, centerY, size*3.2, size*3.2);
  ellipse(centerX, centerY, size*2.1, size*2.1);
  ellipse(centerX, centerY, size, size);
}

