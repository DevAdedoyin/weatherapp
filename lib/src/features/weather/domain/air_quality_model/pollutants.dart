import 'concentration.dart';
import 'additional_info.dart';

class Pollutant {
  final String? code;
  final String? displayName;
  final String? fullName;
  final Concentration? concentration;
  final AdditionalInfo? additionalInfo;

  Pollutant({
    this.code,
    this.displayName,
    this.fullName,
    this.concentration,
    this.additionalInfo,
  });

  factory Pollutant.fromJson(Map<String, dynamic> json) {
    return Pollutant(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
      fullName: json['fullName'] as String,
      concentration: json['concentration'] != null
          ? Concentration.fromJson(
              json['concentration'] as Map<String, dynamic>)
          : null,
      additionalInfo: json['additionalInfo'] != null
          ? AdditionalInfo.fromJson(
              json['additionalInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}
