import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/src/features/share_app/share_app.dart';

class ShareAppScreen extends StatelessWidget {
  final String phoneNumber = '+447300850614';
  final String googleFormUrl = 'https://forms.gle/HiQEtA4QKxJGkD6H8';
  final String contactWebUrl =
      'https://devadedoyin.github.io/weather-monitor-support/';

  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Share App',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose the OS version you want share',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.phone_iphone, color: Colors.green),
                  title: Text('Share for Iphone'),
                  trailing: Icon(Icons.share),
                  subtitle: Text("Tap to share to Iphone users."),
                  onTap: () => ShareApp.shareApp(context, os: "iOS"),
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.phone_android, color: Colors.blue),
                  title: Text('Share for Android'),
                  trailing: Icon(Icons.share),
                  subtitle: Text('Tap to share to Android users.'),
                  onTap: () => ShareApp.shareApp(context, os: "Android"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
