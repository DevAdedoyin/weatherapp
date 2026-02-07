class AdditionalInfo {
  final String? sources;
  final String? effects;

  AdditionalInfo({this.sources, this.effects});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      sources: json['sources'] as String,
      effects: json['effects'] as String,
    );
  }
}
