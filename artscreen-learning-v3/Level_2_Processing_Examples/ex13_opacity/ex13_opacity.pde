void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255);
  
  fill(206,106,106);
  ellipse(50,50,20,20);
  
  /* the last argument 100 means this
   * fill color will have an opacity level
   * of 100, 0 is completely transparent
   * 255 is opaque
   */
  fill(15,216,168,100);
  //fill(#EA2B7E, 100);
  ellipse(60,60,20,20);
}
 