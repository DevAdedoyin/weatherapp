import 'dart:convert';
import 'dart:io';
import 'package:check_app_version/components/dialogs/app_version_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

String appVersion = "1.0.0";

void checkForUpdates(BuildContext context) async {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  try {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/DevAdedoyin/weather_monitor_update_file/master/app_version.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String latestVersion = data['new_app_version'] as String;
      String updateUrl = Platform.isIOS
          ? data['update_url_ios'].toString()
          : data['update_url_android'].toString();

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      appVersion = currentVersion;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lastSkippedVersion = prefs.getString('lastSkippedVersion');

      if (_isUpdateAvailable(currentVersion, latestVersion) &&
          lastSkippedVersion != latestVersion) {
        if (!context.mounted) return;
        AppVersionDialog(
          updateButtonColor: isDarkMode ? Colors.red : Colors.blue,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          title: "Update Your App",
          titleColor: isDarkMode ? Colors.white70 : Colors.black87,
          context: context,
          jsonUrl:
              'https://raw.githubusercontent.com/DevAdedoyin/weather_monitor_update_file/master/app_version.json',
          onPressConfirm: () async {
            await _openStore(updateUrl);
          },
          onPressDecline: () {
            goRouter.pop();
            _saveSkippedVersion(latestVersion);
          },
          laterButtonEnable: true,
        ).show();
      } else {
        print('App is up-to-date or user skipped this version.');
      }
    }
  } catch (e) {
    print('Error checking for updates: $e');
  }
}

bool _isUpdateAvailable(String? current, String latest) {
  List<int> currentParts = current!.split('.').map(int.parse).toList();
  List<int> latestParts = latest.split('.').map(int.parse).toList();

  for (int i = 0; i < latestParts.length; i++) {
    if (i >= currentParts.length || latestParts[i] > currentParts[i]) {
      return true;
    } else if (latestParts[i] < currentParts[i]) {
      return false;
    }
  }
  return false;
}

Future<void> _saveSkippedVersion(String version) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastSkippedVersion', version);
}

Future<void> _openStore(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // print('Could not launch store URL');
  }
}
