import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7,
      width: 7,
      child: CircularProgressIndicator(
        color: AppColors.accentColor,
      ),
    );
  }
}
