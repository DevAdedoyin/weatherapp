import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
// import 'dart:io' show Platform;

// TODO: Platform specific to display apple login.
class ThirdPartyAuthWidgets extends ConsumerWidget {
  const ThirdPartyAuthWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: AppColors.thirdPartyIconBGColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "assets/images/google.png",
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          horizontalGap(30),
          InkWell(
            onTap: () {},
            child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: AppColors.thirdPartyIconBGColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(
                  FontAwesomeIcons.apple,
                  color: Colors.black,
                )),
          ),
          horizontalGap(30),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: AppColors.thirdPartyIconBGColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "assets/images/facebook.png",
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
