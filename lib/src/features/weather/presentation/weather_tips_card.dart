import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class WeatherTipsCard extends ConsumerStatefulWidget {
  final String title;
  final String image;
  final List<String> items;

  const WeatherTipsCard(
      {super.key,
      required this.title,
      required this.image,
      required this.items});

  @override
  ConsumerState<WeatherTipsCard> createState() => _WeatherTipsCardState();
}

class _WeatherTipsCardState extends ConsumerState<WeatherTipsCard> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDarkMode
          ? AppColors.cardDarkModeColor
          : AppColors.cardLightModeColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // elevation: 1,
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Image.asset(image, width: 40, height: 40),
                // const SizedBox(width: 10),
                Text(
                  widget.title,
                  style: GoogleFonts.acme(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...widget.items.map((tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• "),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
