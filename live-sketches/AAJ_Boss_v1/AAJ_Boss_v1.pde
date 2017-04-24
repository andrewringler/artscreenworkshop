/*
 * Title
 * by Yourname
 * 
 * Credits:
 * anyone you took code from and need to credit
 * and the URLs of that code
 */
import artscreen.*;
import processing.video.*;
import largesketchviewer.*;

ArtScreen artScreen;
float x = 1;
float a = 2;
float b = 3;
float c = 4;
float d = 5;
float e = 6;
float f = 7;
float g = 8;
float h = 9;
float i = 10;
float j = 11;
float k = 12;
float l = 13;
float m = 14;
float n = 15;
float o = 16;
float p = 17;
float q = 18;
float r = 19;
float s = 20;
float t = 21;
float u = 22;
float v = 23;
float w = 24;
float y = 25;
float z = 25;
float ab = 25;
float ac = 25;
float ad = 25;
float ae = 25;
float af = 25;
float ag = 25;
float ah = 25;
float ai = 25;
float aj = 25;
float ak = 25;
float al = 25;

float r1, g1, b1;
float pl, dl;

void setup() {
  size(1920, 1080);
  artScreen = new ArtScreen(this, "“The Circle” 2017", "by PAT L", "", color(255), color(0, 1));
}

void draw() {
  background(random(1, 100), (random(1, 10)), 10);

  if (frameCount % 30 == 0) {
    pl = random(1, 4);
    dl = random(1, 200);
  }
  stroke(dl);
  strokeWeight(pl);

  x = x + 1;
  line(x, 1, width, x);

  a = a + 1.5;
  line(a, 1, width, a);

  b = b + 2;
  line(b, 1, width, b);

  c = c + 3;
  line(c, 1, width, c);

  d = d + 4;
  line(d, 1, width, d);

  e = e + 5;
  line(e, 1, width, e);

  g = g + 6;
  line(g, 1, width, g);

  h = h + 7;
  line(h, 1, width, h);

  i = i + 8;
  line(i, 1, width, i);

  j = j + 9;
  line(j, 1, width, j);

  k = k + 10;
  line(k, 1, width, k);

  l = l + 11;
  line(l, 1, width, l);

  m = m + 12;
  line(m, 1, width, m);

  n = n + 13;
  line(n, 1, width, n);

  o = o + 14;
  line(o, 1, width, o);

  p = p + 15;
  line(p, 1, width, p);

  q = q + 16;
  line(q, 1, width, q);

  r = r + 17;
  line(r, 1, width, r);

  s = s + 18;
  line(s, 1, width, s);

  t = t + 19;
  line(t, 1, width, t);

  u = u + 20;
  line(u, 1, width, u);

  v = v + 21;
  line(l, 1, width, l);

  w = w + 22;
  line(w, 1, width, w);

  y = y + 23;
  line(y, 1, width, y);

  z = z + 24;
  line(z, 1, width, z);

  ab = ab + 25;
  line(ab, 1, width, ab);

  ac = ac + 26;
  line(ac, 1, width, ac);

  ad = ad + 27;
  line(ad, 1, width, ad);

  ae = ae + 28;
  line(ae, 1, width, ae);

  af = af + 29;
  line(af, 1, width, af);

  ag = ag + 30;
  line(ah, 1, width, ah);

  ai = ai + 31;
  line(ai, 1, width, ai);

  aj = aj + 32;
  line(aj, 1, width, aj);

  ak = ak + 34;
  line(ak, 1, width, ak);

  al = al + 35;
  line(al, 1, width, al);

  if (frameCount % 120 == 0) {
    r1 = random(0, 200);
    g1 = random(0, 200);
    b1 = random(0, 200);
  }

  fill(r1, g1, b1);
  ellipse(0, 1000, 2050, 2050);
}