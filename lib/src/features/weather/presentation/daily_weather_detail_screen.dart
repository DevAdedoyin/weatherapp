import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/geo_location/repositories/address_repo.dart';
import 'package:weatherapp/src/features/weather/data/repositories/daily_detail_repo.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

class DailyWeatherDetail extends ConsumerStatefulWidget {
  const DailyWeatherDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyWeatherDetailState();
}

class _DailyWeatherDetailState extends ConsumerState<DailyWeatherDetail> {
  @override
  Widget build(BuildContext context) {
    final dailyWeather = ref.watch(dailyWeatherProvider);
    final userCurrentAddress = ref.watch(currentAddress);
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userCurrentAddress,
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.start,
                ),
                Text(
                  dailyWeather.dateTime,
                  textAlign: TextAlign.start,
                ),
                verticalGap(10),
                Align(
                  // width: double.maxFinite,
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Card(
                      color: AppColors.scaffoldBgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 5,
                      child: Image.network(
                        WeatherIcon.weatherIcon(dailyWeather.weather.icon),
                        fit: BoxFit.fill,
                        height: size.width * 0.40,
                        width: size.width * 0.40,
                      ),
                    ),
                  ),
                ),
                verticalGap(15),
                Card(
                  color: AppColors.scaffoldBgColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                    child: Text(
                      "Weather Summary",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    color: AppColors.scaffoldBgColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 7, left: 10, right: 10, top: 5),
                      child: Text(dailyWeather.summary),
                    ),
                  ),
                ),
                verticalGap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
