import 'aqi_index.dart';
import 'pollutants.dart';
import 'health_recommendations.dart';

class AirQualityResponse {
  final String? dateTime;
  final String? regionCode;
  final List<AqiIndex> indexes;
  final List<Pollutant> pollutants;
  final HealthRecommendations? healthRecommendations;

  AirQualityResponse({
    this.dateTime,
    this.regionCode,
    required this.indexes,
    required this.pollutants,
    this.healthRecommendations,
  });

  factory AirQualityResponse.fromJson(Map<String, dynamic> json) {
    try {
      return AirQualityResponse(
        dateTime: json['dateTime'] as String,
        regionCode: json['regionCode'] as String,
        indexes: (json['indexes'] as List? ?? [])
            .map((e) => AqiIndex.fromJson(e as Map<String, dynamic>))
            .toList(),
        pollutants: (json['pollutants'] as List? ?? [])
            .map((e) => Pollutant.fromJson(e as Map<String, dynamic>))
            .toList(),
        healthRecommendations: json['healthRecommendations'] != null
            ? HealthRecommendations.fromJson(
                json['healthRecommendations'] as Map<String, dynamic>)
            : null,
      );
    } catch (e) {
      throw Exception('Failed to parse AirQualityResponse: $e');
    }
  }
}
