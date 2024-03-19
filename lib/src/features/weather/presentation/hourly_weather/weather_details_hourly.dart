import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Other details"),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: GestureDetector(
                      onTap: () {
                        ref.read(openWeatherDetails.notifier).state =
                            ref.read(openWeatherDetails.notifier).state
                                ? false
                                : true;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.inputFieldBG,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: FaIcon(
                          isOpen
                              ? FontAwesomeIcons.chevronUp
                              : FontAwesomeIcons.chevronDown,
                          size: 15,
                        ),
                      )),
                )
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeIn,
            height: isOpen ? size.height * 0.60 : size.height * 0.17,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, pos) {
                  return Card(
                    elevation: 10,
                    color: AppColors.scaffoldBgColor,
                    child: ListTile(
                      leading: SizedBox(
                          height: size.height * 0.05,
                          width: size.height * 0.05,
                          child: Image.asset(
                              "assets/images/${weatherImages[pos]}")),
                      title: Text(
                        weatherTitles[pos],
                        style: textTheme.displaySmall,
                      ),
                      // subtitle: Text("data"),
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
        ],
      ),
    );
  }
}
