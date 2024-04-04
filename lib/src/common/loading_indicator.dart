import 'package:flutter/material.dart';
// import 'package:weatherapp/src/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 12,
      width: 12,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
