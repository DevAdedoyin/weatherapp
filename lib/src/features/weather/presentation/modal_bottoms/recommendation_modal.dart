import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/features/weather/presentation/weather_tips_card.dart';

import '../../data/repositories/weather_tips.dart';
import '../../domain/weather_tips_model.dart';

Future<void> showRecommendationsModalBottom(
    BuildContext context, WidgetRef ref) async {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final tips = await WeatherTipsHelper.getAllTipsForWeather(
      ref.read(weatherId.notifier).state);

  if (!context.mounted) return;

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: isDarkMode ? Colors.black87 : Colors.grey,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Text(
            "Recommendations",
            style:
                GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          verticalGap(10),
          Expanded(
            child: ListView(
              children: [
                WeatherTipsCard(
                  title: "👕 Clothing",
                  image: "assets/images/clothing.jpg",
                  items: tips.clothing,
                ),
                verticalGap(10),
                WeatherTipsCard(
                  title: "🍲 Food",
                  image: "assets/images/food.jpg",
                  items: tips.food,
                ),
                verticalGap(10),
                WeatherTipsCard(
                  title: "🏃 Activities",
                  image: "assets/images/activity.jpg",
                  items: tips.activities,
                ),
                verticalGap(10),
                WeatherTipsCard(
                  title: "🛡 Safety",
                  image: "assets/images/safety.jpg",
                  items: tips.safety,
                ),
                verticalGap(10),
                WeatherTipsCard(
                  title: "🏠 Home & Commute",
                  image: "assets/images/home.jpg",
                  items: tips.homeCommute,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
