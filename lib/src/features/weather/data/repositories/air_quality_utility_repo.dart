import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

String normalizeCountry(String country) {
  if (country == "United States of America") return "United States";
  if (country == "UK") return "United Kingdom";
  return country.trim();
}

// Fetch Air Quality Countries
Future<Set<String>> fetchAirQualityCountries() async {
  final snapshot = await FirebaseFirestore.instance
      .collection("air_quality_countries")
      .where("enabled", isEqualTo: true)
      .get();

  return snapshot.docs.map((doc) => doc["name"] as String).toSet();
}

// Refresh logic (24h)
bool shouldRefresh(int lastSyncMillis) {
  final lastSync = DateTime.fromMillisecondsSinceEpoch(lastSyncMillis);
  return DateTime.now().difference(lastSync).inHours >= 24;
}

// Cache + auto refresh (MAIN FUNCTION)
Future<Set<String>> getAirQualityCountries() async {
  final prefs = await SharedPreferences.getInstance();

  final cached = prefs.getStringList("air_quality_countries");
  final lastSync = prefs.getInt("air_quality_last_sync") ?? 0;

  if (cached != null && !shouldRefresh(lastSync)) {
    return cached.toSet();
  }

  final fresh = await fetchAirQualityCountries();

  await prefs.setStringList("air_quality_countries", fresh.toList());
  await prefs.setInt(
    "air_quality_last_sync",
    DateTime.now().millisecondsSinceEpoch,
  );

  return fresh;
}
