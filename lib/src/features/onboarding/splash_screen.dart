import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/routing/app_routes.dart';

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
        () {
          if (FirebaseAuth.instance.currentUser == null) {
            context.go(AppRoutes.onboarding);
          } else {
            context.go(AppRoutes.userLocatorPage);
          }
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 112,
              width: 112,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child:
                    Image.asset("assets/images/weather.gif", fit: BoxFit.fill),
              ),
            ),
            verticalGap(10),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 5000),
              child: Text(
                "Weather Monitor",
                style: textTheme.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
