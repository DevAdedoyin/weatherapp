import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class UserLocation extends ConsumerStatefulWidget {
  const UserLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLocationState();
}

class _UserLocationState extends ConsumerState<UserLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Let Weather Monitor access your location to give you real-time weather datails on your location."),
            verticalGap(10),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  height: 170,
                  width: 170,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.fontColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    "assets/images/location.png",
                    fit: BoxFit.contain,
                  ),
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text("Enable Location"),
            )
          ]),
    );
  }
}
