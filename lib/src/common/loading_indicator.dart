import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
// import 'package:weatherapp/src/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    return  SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: isDarkMode ? Colors.white : AppColors.accentColor,
        strokeWidth: 4,
      ),
    );
  }
}
