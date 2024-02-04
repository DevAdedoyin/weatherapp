import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  String _status = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'Page One',
              bodyWidget: Column(
                children: [
                  Text(_status),
                  ElevatedButton(
                      onPressed: () {
                        setState(() => _status = 'Going to the next page...');

                        // 3. Use the `currentState` member to access functions defined in `IntroductionScreenState`
                        Future.delayed(const Duration(seconds: 3),
                            () => _introKey.currentState?.next());
                      },
                      child: const Text('Start'))
                ],
              )),
          PageViewModel(
              title: 'Page Two', bodyWidget: const Text('That\'s all folks'))
        ],
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
