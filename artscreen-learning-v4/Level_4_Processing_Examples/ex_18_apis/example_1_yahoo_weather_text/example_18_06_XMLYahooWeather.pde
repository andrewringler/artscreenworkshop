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
  size(200, 200);
  weather = new YahooWeather("02118");
}

void draw() {
  background(255);
  fill(0);

  text("Zip code: " + zip, 10, 50);
  text("Today’s high: " + weather.getTemperature(), 10, 70);
  text("Forecast: " + weather.getDescription(), 10, 90);
}