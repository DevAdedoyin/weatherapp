import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareApp {
  static void shareApp(BuildContext context, {required String os}) async {
    String appLink = os == "iOS"
        ? 'https://apps.apple.com/app/id6751232705'
        : 'https://play.google.com/store/apps/details?id=com.weathermonitor.weatherapp';

    final result = await SharePlus.instance.share(
      ShareParams(
          text:
              "Check out this awesome Weather Monitor app! Download it here: $appLink",
          title: "Share Weather Monitor App"),
    );

    if (result.status == ShareResultStatus.success) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Thanks for sharing Weather Monitor App!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green[900],
        ),
      );
    }
  }
}
