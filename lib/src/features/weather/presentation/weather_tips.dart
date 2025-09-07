// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../constants/app_colors.dart';
// import '../data/repositories/weather_tips.dart';
// import '../domain/weather_tips_model.dart';
//
// class WeatherTipsScreen extends ConsumerWidget {
//   const WeatherTipsScreen({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tips = WeatherTipsHelper.getAllTipsForWeather(
//         ref.read(weatherId.notifier).state);
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Weather Tips",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: isDarkMode ? Colors.red : Colors.blue,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(isDarkMode
//                   ? "assets/images/darkmode.jpg"
//                   : "assets/images/sky.jpg"),
//               fit: BoxFit.cover),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildTipCard(
//               context,
//               title: "👕 Clothing",
//               image: "assets/images/clothing.jpg",
//               items: tips.clothing,
//             ),
//             _buildTipCard(
//               context,
//               title: "🍲 Food",
//               image: "assets/images/food.jpg",
//               items: tips.food,
//             ),
//             _buildTipCard(
//               context,
//               title: "🏃 Activities",
//               image: "assets/images/activity.jpg",
//               items: tips.activities,
//             ),
//             _buildTipCard(
//               context,
//               title: "🛡 Safety",
//               image: "assets/images/safety.jpg",
//               items: tips.safety,
//             ),
//             _buildTipCard(
//               context,
//               title: "🏠 Home & Commute",
//               image: "assets/images/home.jpg",
//               items: tips.homeCommute,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTipCard(BuildContext context,
//       {required String title,
//       required String image,
//       required List<String> items}) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Card(
//       color: isDarkMode
//           ? AppColors.cardDarkModeColor
//           : AppColors.cardLightModeColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Image.asset(image, width: 40, height: 40),
//                 const SizedBox(width: 10),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             ...items.map((tip) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("• "),
//                       Expanded(
//                         child: Text(
//                           tip,
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
