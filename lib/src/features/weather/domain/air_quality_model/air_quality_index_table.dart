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
    "The air is clean and safe for everyone.",
    "0 to 50",
    Color.fromARGB(255, 71, 230, 14),
  ),
  AirQualityIndexChart(
    "Moderate",
    "Yellow",
    "The air is okay for most people. If you are sensitive, you may feel slight discomfort.",
    "51 to 100",
    Color.fromARGB(255, 250, 255, 41),
  ),
  AirQualityIndexChart(
    "Unhealthy for Sensitive Groups",
    "Orange",
    "People with asthma or breathing issues may feel unwell. Others are usually fine.",
    "101 to 150",
    Color.fromARGB(255, 240, 133, 16),
  ),
  AirQualityIndexChart(
    "Unhealthy",
    "Red",
    "The air is unhealthy. Many people may start to feel effects, especially those with health conditions.",
    "151 to 200",
    Color.fromARGB(255, 255, 0, 0),
  ),
  AirQualityIndexChart(
    "Very Unhealthy",
    "Purple",
    "The air is very unhealthy. Everyone may feel the effects. Try to stay indoors if possible.",
    "201 to 300",
    Color.fromARGB(255, 135, 58, 192),
  ),
  AirQualityIndexChart(
    "Hazardous",
    "Maroon",
    "The air is dangerous. Avoid going outside and limit physical activity.",
    "301 and higher",
    Color.fromARGB(255, 131, 33, 47),
  ),
];
