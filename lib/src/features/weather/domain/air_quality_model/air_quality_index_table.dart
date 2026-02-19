import 'dart:ui';

class AirQualityIndexChart {
  final String airQualityStatus;
  final String color;
  final String indexValue;
  final String description;
  final Color rgb;

  AirQualityIndexChart(this.airQualityStatus, this.color, this.description,
      this.indexValue, this.rgb);
}

List<AirQualityIndexChart> airQualityIndexChart = [
  AirQualityIndexChart(
    "Good",
    "Green",
    "Air quality is satisfactory, and air pollution poses little or no risk.",
    "0 to 50",
    Color.fromARGB(255, 71, 230, 14),
  ),
  AirQualityIndexChart(
    "Moderate",
    "Yellow",
    "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.",
    "51 to 100",
    Color.fromARGB(255, 250, 255, 41),
  ),
  AirQualityIndexChart(
    "Unhealthy for Sensitive Groups",
    "Orange",
    "Members of sensitive groups may experience health effects. The general public is less likely to be affected.",
    "101 to 150",
    Color.fromARGB(255, 240, 133, 16),
  ),
  AirQualityIndexChart(
      "Unhealthy",
      "Red",
      "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.",
      "151 to 200",
      Color.fromARGB(255, 255, 0, 0)),
  AirQualityIndexChart(
    "Very Unhealthy",
    "Purple",
    "Health alert: The risk of health effects is increased for everyone.",
    "201 to 300",
    Color.fromARGB(255, 135, 58, 192),
  ),
  AirQualityIndexChart(
      "Hazardous",
      "Maroon",
      "Health warning of emergency conditions: everyone is more likely to be affected.",
      "301 and higher",
      Color.fromARGB(255, 131, 33, 47)),
];
