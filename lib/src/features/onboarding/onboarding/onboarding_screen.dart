import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/onboarding/onboarding/onboarding_items.dart';
import 'package:weatherapp/src/routing/app_routes.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        done: Text(
          "Done",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.white),
        ),
        onDone: () => context.go(AppRoutes.login),
        onSkip: () => context.go(AppRoutes.login),
        skip: Text(
          "Skip",
          style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.white, fontSize: 15),
        ),
        showSkipButton: true,
        showBackButton: false,
        showNextButton: true,
        next: Text("Next",
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.white, fontSize: 15)),
        back: const Icon(Icons.arrow_back),
        dotsDecorator: DotsDecorator(
          size: const Size.square(8.0),
          activeSize: const Size(18.0, 8.0),
          activeColor: AppColors.accentColor,
          color:  isDarkMode ? Colors.grey : AppColors.deepBlack,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        skipStyle: TextButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            elevation: 5,
            textStyle: textTheme.titleSmall,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            )),
        doneStyle: TextButton.styleFrom(
            backgroundColor: AppColors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            textStyle: textTheme.bodyMedium),
        nextStyle: TextButton.styleFrom(
            // foregroundColor: Colors.black,
            backgroundColor: isDarkMode ? Colors.grey : AppColors.deepBlack,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            textStyle: textTheme.bodyMedium),
      ),
    );
  }
}
