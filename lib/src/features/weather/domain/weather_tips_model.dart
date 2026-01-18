import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherTipsCategory {
  final List<String> clothing;
  final List<String> food;
  final List<String> activities;
  final List<String> safety;
  final List<String> homeCommute;

  WeatherTipsCategory({
    required this.clothing,
    required this.food,
    required this.activities,
    required this.safety,
    required this.homeCommute,
  });
}

class WeatherTipsHelper {
  // static Future<void> uploadRecommendations() async {
  //   final firestore = FirebaseFirestore.instance;
  //
  //   for (final entry in _tips.entries) {
  //     await firestore
  //         .collection('recommendations')
  //         .doc(entry.key)
  //         .set(entry.value);
  //   }
  // }

  // static final Map<String, Map<String, List<String>>> _tips = {
  //
  //
  //
  // };

  static Future<WeatherTipsCategory> getAllTipsForWeather(
      double weatherId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recommendations').get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No recommendations found');
    }

    // Find matching document ID based on weatherId
    String matchedKey = snapshot.docs.map((doc) => doc.id).firstWhere(
      (range) {
        if (range.contains('-')) {
          final parts = range.split('-');
          final start = int.parse(parts[0]);
          final end = int.parse(parts[1]);
          return weatherId >= start && weatherId <= end;
        } else {
          return weatherId == int.parse(range);
        }
      },
      orElse: () => '800',
    );

    // Get the matching document data
    final matchedDoc = snapshot.docs.firstWhere((doc) => doc.id == matchedKey);

    final data = matchedDoc.data();

    return WeatherTipsCategory(
      clothing: _toStringList(data['clothing']),
      food: _toStringList(data['food']),
      activities: _toStringList(data['activities']),
      safety: _toStringList(data['safety']),
      homeCommute: _toStringList(data['home_commute']),
    );
  }

// static Future<WeatherTipsCategory> getAllTipsForWeather(double weatherId) async {
//   final recommendation = await FirebaseFirestore.instance
//       .collection('recommendations').get();
//
//   print("Recommendation $recommendation");
//
//   String key = _tips.keys.firstWhere((range) {
//     if (range.contains('-')) {
//       final parts = range.split('-');
//       int start = int.parse(parts[0]);
//       int end = int.parse(parts[1]);
//       return weatherId >= start && weatherId <= end;
//     } else {
//       return weatherId == int.parse(range);
//     }
//   }, orElse: () => "800");
//
//   final category = _tips[key]!;
//   return WeatherTipsCategory(
//     clothing: category["clothing"]!,
//     food: category["food"]!,
//     activities: category["activities"]!,
//     safety: category["safety"]!,
//     homeCommute: category["home_commute"]!,
//   );
// }
}

class WeatherImages {
  static String weatherImages(double wId) {
    return wId >= 200 && wId <= 232
        ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269625/Weather%20Monitor/Home%20Description%20Images/thunderstormgif_fs49o9.gif"
        : wId >= 300 && wId <= 321
            ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269674/Weather%20Monitor/Home%20Description%20Images/drizzle_xjrqra.gif"
            : wId >= 500 && wId <= 531
                ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269699/Weather%20Monitor/Home%20Description%20Images/raining_xekkzh.gif"
                : wId >= 600 && wId <= 622
                    ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269739/Weather%20Monitor/Home%20Description%20Images/snow_mnvmwb.gif"
                    : wId >= 701 && wId <= 781
                        ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269799/Weather%20Monitor/Home%20Description%20Images/atmosphere_xnqnw6.gif"
                        : wId == 800
                            ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269795/Weather%20Monitor/Home%20Description%20Images/clouds_mbekqb.gif"
                            : wId >= 801 && wId <= 804
                                ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269796/Weather%20Monitor/Home%20Description%20Images/wId_f28hd9.gif"
                                : "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269796/Weather%20Monitor/Home%20Description%20Images/wId_f28hd9.gif";
  }
}

List<String> _toStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  return [];
}
