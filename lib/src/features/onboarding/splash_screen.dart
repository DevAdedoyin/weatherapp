import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/features/onboarding/launch_counter.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _visible = false;

  // final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
      Future.delayed(
        const Duration(milliseconds: 5000),
        () async {
          if (FirebaseAuth.instance.currentUser == null) {
            int launchNumber = await LaunchCounter.launchCounter();
            if (launchNumber > 1) {
              Future.delayed(Duration(milliseconds: 100), () => goRouter.go(
                  AppRoutes.userLocatorPage
                  // AppRoutes.newOnboarding
              ));
            } else {
              print(LaunchCounter.launchCounter());
              goRouter.go(AppRoutes.newOnboarding);
            }
          } else {
            goRouter.go(
                // AppRoutes.newOnboarding
                AppRoutes.userLocatorPage
                );
          }
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.13,
                    width: size.height * 0.13,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/images/weather.gif",
                          fit: BoxFit.fill),
                    ),
                  ),
                  // verticalGap(10),
                  // AnimatedOpacity(
                  //   opacity: _visible ? 1.0 : 0.0,
                  //   duration: const Duration(milliseconds: 5000),
                  //   child: Text(
                  //     "Weather Monitor",
                  //     style: textTheme.titleMedium,
                  //   ),
                  // ),
                ],
              ),
            ),
            // verticalGap(300),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   margin: EdgeInsets.only(bottom: 30),
            //   child: Text(
            //     "Powered by Pauversildo",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
