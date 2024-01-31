import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
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
              height: 110,
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child:
                    Image.asset("assets/images/weather.gif", fit: BoxFit.fill),
              ),
            ),
            verticalGap(7.0),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 2000),
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
