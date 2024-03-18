import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class WeatherDetailsHourly extends StatefulWidget {
  const WeatherDetailsHourly({super.key});

  @override
  State<WeatherDetailsHourly> createState() => _WeatherDetailsHourlyState();
}

class _WeatherDetailsHourlyState extends State<WeatherDetailsHourly> {
  List<String> weatherTitles = [
    "Pressure",
    "Humidity",
    "Dew Point",
    "Visibility",
    "Wind Speed",
    "Wind Degree",
    "Wind Gust",
  ];

  List<String> weatherImages = [
    "pressure.png",
    "humidity.png",
    "dewpoint.png",
    "visibility.png",
    "windspeed.png",
    "winddegree.png",
    "windgust.png",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: Card(
        color: AppColors.scaffoldBgColor,
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeIn,
          height: size.height * 0.17,
          child: ListView.builder(
              itemBuilder: (_, pos) {
                return Card(
                  elevation: 10,
                  color: AppColors.scaffoldBgColor,
                  child: ListTile(
                    leading: SizedBox(
                        height: size.height * 0.05,
                        width: size.height * 0.05,
                        child:
                            Image.asset("assets/images/${weatherImages[pos]}")),
                    title: Text(
                      weatherTitles[pos],
                      style: textTheme.displaySmall,
                    ),
                    trailing: Text(
                      "20",
                      style: textTheme.displaySmall,
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: weatherTitles.length),
        ),
      ),
    );
  }
}
