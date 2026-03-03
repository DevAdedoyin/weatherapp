import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

import '../../../ads/ad_counter.dart';
import '../../../ads/data/repositories/interstital_repository.dart';
import '../../../temeperature_scale/data/temperature_data.dart';
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
                    style: GoogleFonts.aBeeZee(color: Colors.white)
                ),
                InkWell(
                    onTap: () {
                      ref.read(openWeatherDetails.notifier).state =
                          ref.read(openWeatherDetails.notifier).state
                              ? false
                              : true;
                      // TODO IF ADD IS NEEDED IN THE FUTURE
                      // ref.read(interstitialAdProvider.notifier).showAd();
                      AdDisplayCounter.addDisplayCounter(
                          ref.read(interstitialAdProvider.notifier));
                    },
                    child: Card(
                      elevation: 3,
                      color: isDarkMode ? Colors.red : Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 5),
                        child: Text(
                          isOpen ? "See less" : "See more",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            height: isOpen ? size.height * 0.70 : size.height * 0.40,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (_, pos) {
                  List<String> details = [
                    hourlyWeatherState.pressure!,
                    "${hourlyWeatherState.humidity!}%",
                    "",
                    // hourlyWeatherState.dewPoint!,
                    hourlyWeatherState.visibility!,
                    "${hourlyWeatherState.windSpeed!}m/s",
                    hourlyWeatherState.windDegree!,
                    hourlyWeatherState.windGust!,
                  ];
                  return Card(
                    // elevation: 3,
                    color: isDarkMode
                        ? AppColors.cardDarkModeColor
                        : AppColors.cardLightModeColor,
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
                        style: GoogleFonts.acme(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      // subtitle: Text("data"),
                      trailing: pos == 2
                          ? FutureBuilder<String>(
                              future: TemperatureConverter.formatWithPrefs(
                                double.tryParse(hourlyWeatherState.dewPoint!) ??
                                    0,
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const SizedBox.shrink();
                                return Text(
                                  snapshot.data!,
                                  style: GoogleFonts.acme(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            )
                          : Text(details[pos],
                              style: GoogleFonts.acme(
                                  fontSize: 14.5, fontWeight: FontWeight.w700)),
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
