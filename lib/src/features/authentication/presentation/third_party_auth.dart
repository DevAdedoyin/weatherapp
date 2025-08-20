import 'dart:io';

import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/apple_signin_datasource.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/facebook_signin_datasource.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/google_signin_datasource.dart';
// import 'dart:io' show Platform;

class ThirdPartyAuthWidgets extends ConsumerWidget {
  const ThirdPartyAuthWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final googleSignIn = ref.read(googleSignInProvider);
    final appleAuth = AppleAuth();
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => signInWithGoogle(context: context),
            splashColor: Colors.transparent,
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
          if (Platform.isIOS) horizontalGap(30),
          if (Platform.isIOS)
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => appleAuth.signInWithApple(context: context),
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
          // horizontalGap(20),
          // InkWell(
          //   splashColor: Colors.transparent,
          //   onTap: () => loginWithFacebook(context: context),
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     padding: const EdgeInsets.all(7),
          //     decoration: BoxDecoration(
          //         color: AppColors.thirdPartyIconBGColor,
          //         borderRadius: BorderRadius.circular(20)),
          //     child: Image.asset(
          //       "assets/images/facebook.png",
          //       fit: BoxFit.contain,
          //       alignment: Alignment.center,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
