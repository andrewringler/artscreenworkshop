int opacity = 0;

void setup() {
  size(300,300);
  background(255);
}

void draw() {
  background(255);
  
  fill(206,106,106);
  ellipse(50,50,20,20);
  
  /* opacity of this ellipse will start at 0
   * meaning fully transparent and then gradually
   * increase until it is fully opaque
   */
  fill(15,216,168,opacity);
  ellipse(60,60,20,20);
  opacity = opacity + 1;
}
 



