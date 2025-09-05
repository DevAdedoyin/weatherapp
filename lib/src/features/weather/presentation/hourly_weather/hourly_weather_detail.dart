import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/weather/data/repositories/hourly_weather_detail.dart';

import 'package:weatherapp/src/features/weather/presentation/hourly_weather/weather_details_hourly.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

import '../../../ads/data/repositories/banner_repository.dart';

class HourlyWeatherDetailsScreen extends ConsumerStatefulWidget {
  const HourlyWeatherDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HourlyWeatherDetailsScreenState();
}

class _HourlyWeatherDetailsScreenState
    extends ConsumerState<HourlyWeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final bannerAd = ref.watch(bannerHourlyAdProvider);
    Size size = MediaQuery.of(context).size;
    final hourlyWeatherState = ref.watch(hourlyWeatherDetails);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hourlyWeatherState.address,
                style: textTheme.bodyLarge,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: isDarkMode ? Colors.red : Colors.blue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Text(
                  hourlyWeatherState.date!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                // verticalGap(70.0),
                GradientText(
                  hourlyWeatherState.time!,
                  style: GoogleFonts.robotoCondensed(
                    height: 1,
                    fontSize: size.height < 650 ? 40 : 70.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  colors: const [
                    Colors.white,
                    Colors.grey,
                    Colors.white,
                    // Colors.grey,
                  ],
                ),
                verticalGap(size.height * 0.02),
                Text(
                  "Weather Report",
                  style: textTheme.bodyMedium,
                ),
                verticalGap(size.height * 0.005),
                SizedBox(
                  // color: Colors.red,
                  height: size.width * 0.40,
                  width: size.width * 0.40,
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white12 : Colors.black12,
                        borderRadius: BorderRadius.circular(500)),
                    child: Hero(
                      tag: "weather-image-${hourlyWeatherState.position}",
                      child: Image.network(
                        WeatherIcon.weatherIcon(hourlyWeatherState.image!),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        // height: size.width * 0.07,
                        // width: size.width * 0.07,
                        // alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              "${hourlyWeatherState.temp!}°",
                              style: GoogleFonts.robotoCondensed(
                                height: 1,
                                fontSize: size.height < 650 ? 70 : 100.0,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: const [
                                Colors.white,
                                Colors.grey,
                                Colors.white,
                                // Colors.grey,
                              ],
                            ),
                            Text(
                              "Feel like: ${hourlyWeatherState.feelsLike}°",
                              style: textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.40,
                        // color: Colors.blue[200],
                        // Adjust height as needed
                        child: Text(
                          hourlyWeatherState.desctiption!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalGap(20),
                if (bannerAd != null)
                  SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
                const WeatherDetailsHourly()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
