import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

import '../../data/repositories/hourly_weather_detail.dart';

class WeatherDetailsHourly extends ConsumerStatefulWidget {
  const WeatherDetailsHourly({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WeatherDetailsHourlyState();
}

class _WeatherDetailsHourlyState extends ConsumerState<WeatherDetailsHourly> {
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
    final isOpen = ref.watch(openWeatherDetails);
    final hourlyWeatherState = ref.watch(hourlyWeatherDetails);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Other details",
                  style: textTheme.titleMedium,
                ),
                InkWell(
                    onTap: () {
                      ref.read(openWeatherDetails.notifier).state =
                          ref.read(openWeatherDetails.notifier).state
                              ? false
                              : true;
                    },
                    child: Card(
                      elevation: 3,
                      color: isDarkMode ? Colors.white12 : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Text(
                          isOpen
                              ? "See less"
                              : "See more",
                          style: TextStyle(),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            height: isOpen ? size.height * 0.60 : size.height * 0.34,
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, pos) {
                  List<String> details = [
                    hourlyWeatherState.pressure!,
                    hourlyWeatherState.humidity!,
                    hourlyWeatherState.dewPoint!,
                    hourlyWeatherState.visibility!,
                    hourlyWeatherState.windSpeed!,
                    hourlyWeatherState.windDegree!,
                    hourlyWeatherState.windGust!,
                  ];
                  return Card(
                    elevation: 3,
                    color:
                        isDarkMode ? AppColors.scaffoldBgColor : Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:
                                isDarkMode ? Colors.white12 : Colors.black12),
                        height: size.height * 0.035,
                        width: size.height * 0.035,
                        child: Image.network(
                          WeatherIcon.weatherIcon(hourlyWeatherState.image!),
                          // fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(
                        weatherTitles[pos],
                        style: textTheme.bodyMedium,
                      ),
                      // subtitle: Text("data"),
                      trailing: Text(
                        details[pos],
                        style: textTheme.bodySmall,
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: weatherTitles.length),
          ),
        ],
      ),
    );
  }
}
