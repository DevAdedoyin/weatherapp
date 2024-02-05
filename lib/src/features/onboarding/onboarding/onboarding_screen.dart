import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/onboarding/onboarding/onboarding_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // final _introKey = GlobalKey<IntroductionScreenState>();
  // String _status = 'Waiting...';

  final pages = onboardingItemsList
      .map((onboardingBody) =>
          PageViewModel(title: "", bodyWidget: onboardingBody))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        done: const Text("Done"),
        onDone: () {},
        skip: const Text("Skip"),
        showSkipButton: true,
        showBackButton: false,
        showNextButton: true,
        next: const Text("Next"),
        back: const Icon(Icons.arrow_back),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.secondaryColor,
          color: AppColors.fontColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        baseBtnStyle: TextButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
        ),
        skipStyle: TextButton.styleFrom(foregroundColor: Colors.red),
        doneStyle: TextButton.styleFrom(foregroundColor: Colors.green),
        nextStyle: TextButton.styleFrom(foregroundColor: Colors.blue),
      ),
    );
  }
}