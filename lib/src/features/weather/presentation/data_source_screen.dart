import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class DataSourceScreen extends StatelessWidget {
  const DataSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Sources',
          style: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDarkMode ? Colors.red : Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isDarkMode
                    ? "assets/images/darkmode.jpg"
                    : "assets/images/sky.jpg"),
                fit: BoxFit.cover),
          ),
          child: ListView.builder(
            itemCount: listOfDataSourceAPI.length,
            itemBuilder: (_, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: ClipOval(
                    child: SizedBox(
                      width: size.height * 0.04,
                      height: size.height * 0.04,
                      child: Image.network(
                        listOfDataSourceAPI[index].logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(listOfDataSourceAPI[index].title),
                  subtitle: Text(listOfDataSourceAPI[index].source),
                ),
              );
            },
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}

class DataSourcesAPI {
  final String title;
  final String source;
  final String logo;

  DataSourcesAPI(
      {required this.title, required this.source, required this.logo});
}

List<DataSourcesAPI> listOfDataSourceAPI = [
  DataSourcesAPI(
      title: "Current Weather",
      source: "Open Weather Map",
      logo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9sB0plzX8wHpPr-EkRFw8bYZGrLAh54G_A&s"),
  DataSourcesAPI(
      title: "Daily Weather",
      source: "Open Weather Map",
      logo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9sB0plzX8wHpPr-EkRFw8bYZGrLAh54G_A&s"),
  DataSourcesAPI(
      title: "Search Weather",
      source: "Open Weather Map",
      logo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9sB0plzX8wHpPr-EkRFw8bYZGrLAh54G_A&s"),
  DataSourcesAPI(
      title: "Air Quality Index",
      source: "Google Maps Platform",
      logo:
          "https://developers.google.com/static/maps/images/google-maps-platform-1200x675.png"),
];
