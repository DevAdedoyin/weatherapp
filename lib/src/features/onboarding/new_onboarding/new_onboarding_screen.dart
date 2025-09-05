import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/onboarding/new_onboarding/button_widget.dart';
import 'package:weatherapp/src/routing/app_routes.dart';

import '../../../routing/go_router_provider.dart';
import 'new_onboarding_data/new_onboarding_page_list.dart';
import 'onboarding_state.dart';

class NewOnboardingScreen extends ConsumerStatefulWidget {
  const NewOnboardingScreen({super.key});

  @override
  ConsumerState<NewOnboardingScreen> createState() =>
      _NewOnboardingScreenState();
}

class _NewOnboardingScreenState extends ConsumerState<NewOnboardingScreen> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentPage);
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.80,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  ref.read(currentPage.notifier).state = index;
                },
                children: isDarkMode
                    ? listOfOnboardingPages
                    : listOfOnboardingPagesLightMode,
              ),
            ),
            isDarkMode
                ? SizedBox(
                    width: size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          height: 10,
                          width: index == currentIndex ? 25 : 10,
                          decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? Colors.red
                                  : Colors.white60,
                              borderRadius: BorderRadius.circular(50)),
                        );
                      }),
                    ),
                  )
                : SizedBox(
                    width: size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          height: 10,
                          width: index == currentIndex ? 25 : 10,
                          decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? Colors.blue[800]
                                  : Colors.white70,
                              borderRadius: BorderRadius.circular(50)),
                        );
                      }),
                    ),
                  ),
            SizedBox(
              height: size.height * 0.019,
            ),
            ButtonWidget(
              text: currentIndex == 3 ? "Get Started" : "Continue",
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              height: size.height * 0.05,
              width: size.width * 0.85,
              textColor: isDarkMode ? Colors.black : Colors.white,
              onPress: () {
                if (currentIndex == 3) {
                  goRouter.go(AppRoutes.userLocatorPage);
                }
                ref.read(currentPage.notifier).state++;
                pageController.animateToPage(
                    ref.read(currentPage.notifier).state,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              },
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            ButtonWidget(
              text: "Skip",
              backgroundColor: isDarkMode ? Colors.red : Colors.blue,
              height: size.height * 0.05,
              width: size.width * 0.85,
              textColor: Colors.white,
              onPress: () {
                goRouter.go(AppRoutes.userLocatorPage);
              },
            )
          ],
        ),
      ),
    );
  }
}
