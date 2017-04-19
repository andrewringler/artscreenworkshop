/* Adapted from
 * https://processing.org/reference/minute_.html
 */
void setup() {
  size(600, 600);
}

void draw() {
  background(204, 204, 204);
  stroke(100, 100, 100);

  float s = second();  // Values from 0 - 59
  float m = minute();  // Values from 0 - 59
  float h = hour();    // Values from 0 - 23

  // remap all values to width of sketch
  s = map(s, 0, 59, 0, width);
  m = map(m, 0, 59, 0, width);
  h = map(h, 0, 23, 0, width);

  // divide sketch into 3 sections
  float sec1 = 0;
  float sec2 = 0.33 * height;
  float sec3 = 0.66 * height;
  float sec4 = height;

  strokeWeight(1);
  line(s, sec1, s, sec2);

  strokeWeight(4);
  line(m, sec2, m, sec3);

  strokeWeight(10);
  line(h, sec3, h, sec4);
}