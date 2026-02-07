class AqiIndex {
  final String? code;
  final String? displayName;
  final int? aqi;
  final String? category;
  final String? dominantPollutant;

  AqiIndex({
    this.code,
    this.displayName,
    this.aqi,
    this.category,
    this.dominantPollutant,
  });

  factory AqiIndex.fromJson(Map<String, dynamic> json) {
    return AqiIndex(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
      aqi: json['aqi'] as int,
      category: json['category'] as String,
      dominantPollutant: json['dominantPollutant'] as String,
    );
  }
}
