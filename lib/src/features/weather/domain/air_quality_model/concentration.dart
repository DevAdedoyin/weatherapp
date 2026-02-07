class Concentration {
  final double? value;
  final String? units;

  Concentration({this.value, this.units});

  factory Concentration.fromJson(Map<String, dynamic> json) {
    return Concentration(
      value: (json['value'] as num?)?.toDouble(),
      units: json['units'] as String,
    );
  }
}
