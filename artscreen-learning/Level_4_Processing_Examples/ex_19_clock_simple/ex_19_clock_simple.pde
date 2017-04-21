void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  stroke(250);

  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23

  String time = h + ":" + m + ":" + s;
  textSize(36);
  textAlign(CENTER, CENTER);
  text(time, 300, 300);
}