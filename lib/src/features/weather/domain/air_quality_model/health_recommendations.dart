class HealthRecommendations {
  final String? generalPopulation;
  final String? elderly;
  final String? lungDiseasePopulation;
  final String? heartDiseasePopulation;
  final String? athletes;
  final String? pregnantWomen;
  final String? children;

  HealthRecommendations({
    this.generalPopulation,
    this.elderly,
    this.lungDiseasePopulation,
    this.heartDiseasePopulation,
    this.athletes,
    this.pregnantWomen,
    this.children,
  });

  factory HealthRecommendations.fromJson(Map<String, dynamic> json) {
    return HealthRecommendations(
      generalPopulation: json['generalPopulation'] as String,
      elderly: json['elderly'] as String,
      lungDiseasePopulation: json['lungDiseasePopulation'] as String,
      heartDiseasePopulation: json['heartDiseasePopulation'] as String,
      athletes: json['athletes'] as String,
      pregnantWomen: json['pregnantWomen'] as String,
      children: json['children'] as String,
    );
  }
}
