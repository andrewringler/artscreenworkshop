class YahooWeather {
  XML forecast;

  public YahooWeather(String zip) {
    // URL updated 2016-08-02, https://developer.yahoo.com/weather/
    String url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" +zip+ "%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";

    // Load the XML document
    XML xml = loadXML(url);

    // Grab the element we want
    forecast = xml.getChild("results/channel/item/yweather:forecast");
  }

  public int getTemperature() {
    return forecast.getInt("high");
  }

  public String getDescription() {
    return forecast.getString("text");
  }
}