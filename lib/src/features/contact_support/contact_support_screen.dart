import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatelessWidget {
  final String phoneNumber = '+447300850614';
  final String googleFormUrl = 'https://forms.gle/HiQEtA4QKxJGkD6H8';

  const ContactSupportPage({super.key});

  Future<void> _launchPhone() async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  Future<void> _launchGoogleForm() async {
    final Uri url = Uri.parse(googleFormUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $googleFormUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Support',
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
                'Need help? Choose one of the options below to contact our support team.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text('Call Support'),
                  subtitle: Text(phoneNumber),
                  onTap: _launchPhone,
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.contact_mail, color: Colors.blue),
                  title: Text('Contact via Google Form'),
                  subtitle: Text('Fill out the form to reach us'),
                  onTap: _launchGoogleForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
