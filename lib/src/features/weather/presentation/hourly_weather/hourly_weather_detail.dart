import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/weather/data/repositories/hourly_weather_detail.dart';
import 'package:weatherapp/src/features/weather/presentation/hourly_weather/weather_details_hourly.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

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
    Size size = MediaQuery.of(context).size;
    final hourlyWeatherState = ref.watch(hourlyWeatherDetails);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hourlyWeatherState.location!,
              style: textTheme.displaySmall,
            ),
            Text(
              hourlyWeatherState.date!,
              style:
                  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GradientText(
              hourlyWeatherState.time!,
              style: GoogleFonts.robotoCondensed(
                height: 1,
                fontSize: 70.0,
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
            Text(
              "Weather Report",
              style: textTheme.displaySmall,
            ),
            verticalGap(2),
            SizedBox(
              // color: Colors.red,
              height: size.width * 0.6,
              width: size.width * 0.6,
              child: Card(
                color: AppColors.scaffoldBgColor,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Hero(
                  tag: "weather-image-${hourlyWeatherState.position}",
                  child: Image.network(
                    WeatherIcon.weatherIcon(hourlyWeatherState.image!),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                    // height: size.width * 0.7,
                    // width: size.width * 0.7,
                    alignment: Alignment.center,
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
                            fontSize: 100.0,
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
                          style: GoogleFonts.roboto(
                              fontSize: 17, fontWeight: FontWeight.w800),
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
                          fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            verticalGap(20),
            const WeatherDetailsHourly()
          ],
        ),
      ),
    );
  }
}
