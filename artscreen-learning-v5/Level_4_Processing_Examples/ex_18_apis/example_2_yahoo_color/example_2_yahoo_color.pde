/**
 *
 * Adapted from
 * Loading XML Data
 * by Daniel Shiffman.  
 * 
 * This example demonstrates how to use loadXML()
 * to retrieve data from an XML document via a URL
 */

String zip = "02118";
YahooWeather weather;

void setup() {
  size(800, 800);
  weather = new YahooWeather("02118");
  colorMode(HSB, 360, 1.0, 1.0, 1.0);
  background(0);
}

void draw() {
  // assume a min temp of 20deg. and a max temp of 100 degrees
  int t = constrain(weather.getTemperature(), 20, 100);
  
  // map current temperature to a hue in HSV
  // blue to red, cold to hot
  float hue = map(t, 20, 100, 167, 360);

  background(hue, 1, 1, 1);
}