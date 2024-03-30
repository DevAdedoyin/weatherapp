import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
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

    final daily = [
      dailyWeather.temp.morn,
      dailyWeather.temp.eve,
      dailyWeather.temp.night,
      dailyWeather.temp.min,
      dailyWeather.temp.max
    ];
    final dayOfTheDay = ["Morning", "Evening", "Night", "Minimum", "Maximum"];

    final feelsLike = [
      dailyWeather.feelsLike.morn,
      dailyWeather.feelsLike.eve,
      dailyWeather.feelsLike.night,
      dailyWeather.feelsLike.night,
      dailyWeather.feelsLike.day,
    ];

    final sunrise =
        DateTime.fromMillisecondsSinceEpoch(dailyWeather.sunrise * 1000);
    final sunset =
        DateTime.fromMillisecondsSinceEpoch(dailyWeather.sunset * 1000);
    final moonrise =
        DateTime.fromMillisecondsSinceEpoch(dailyWeather.moonrise * 1000);
    final moonset =
        DateTime.fromMillisecondsSinceEpoch(dailyWeather.moonset * 1000);
    String formattedSunrise = DateFormat('HH:mm a').format(sunrise);
    String formattedSunset = DateFormat('HH:mm a').format(sunset);
    String formattedMoonrise = DateFormat('HH:mm a').format(moonrise);
    String formattedMoonset = DateFormat('HH:mm a').format(moonset);

    final Map<String, dynamic> otherWeatherDetails = {
      "Pressure": dailyWeather.pressure,
      "Sunrise": formattedSunrise,
      "Humidity": dailyWeather.humidity,
      "Wind Speed": dailyWeather.windSpeed,
      "Sunset": formattedSunset,
      "Dew Point": dailyWeather.dewPoint,
      "Wind Degree": dailyWeather.windDegree,
      "Moonrise": formattedMoonrise,
      "Moonset": formattedMoonset,
    };

    // final tempContainer = ref.watch(temperatureContainerTempHeight);
    final isTempContainerOpen = ref.watch(isDailyContainerTempOpen);
    final isDailyOtherContainerOpen =
        ref.watch(isDailyOtherDetailContainerOpen);

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
                      child: Text(dailyWeather.summary,
                          style: GoogleFonts.roboto(fontSize: 12)),
                    ),
                  ),
                ),
                verticalGap(5),
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
                              "${dailyWeather.temp.day.round()}°",
                              style: GoogleFonts.robotoCondensed(
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
                              "Feel like: ${dailyWeather.feelsLike.day.round()}°c",
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
                          dailyWeather.weather.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalGap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temperature",
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                        onTap: () {
                          ref.read(isDailyContainerTempOpen.notifier).state =
                              ref.read(isDailyContainerTempOpen.notifier).state
                                  ? false
                                  : true;
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: AppColors.scaffoldBgColor,
                            child: Icon(isTempContainerOpen
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.keyboard_arrow_down_sharp)))
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isTempContainerOpen
                      ? size.height * 0.53
                      : size.height * 0.11,
                  // color: AppColors.cardBgColor,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daily.length,
                      itemBuilder: (context, pos) {
                        return Card(
                          elevation: 5,
                          color: AppColors.scaffoldBgColor,
                          child: ListTile(
                            leading: Card(
                              color: AppColors.scaffoldBgColor,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.network(WeatherIcon.weatherIcon(
                                  dailyWeather.weather.icon)),
                            ),
                            dense: false,
                            title: Text(
                              dayOfTheDay[pos].toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              "Feels like ${feelsLike[pos].round().toString()}°c",
                              style: GoogleFonts.roboto(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              "${daily[pos].round().toString()}°c",
                              style: GoogleFonts.roboto(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                          ),
                        );
                      }),
                ),
                verticalGap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Other details",
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                        onTap: () {
                          ref
                              .read(isDailyOtherDetailContainerOpen.notifier)
                              .state = ref
                                  .read(
                                      isDailyOtherDetailContainerOpen.notifier)
                                  .state
                              ? false
                              : true;
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: AppColors.scaffoldBgColor,
                            child: Icon(isDailyOtherContainerOpen
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.keyboard_arrow_down_sharp)))
                  ],
                ),
                AnimatedContainer(
                  height: isDailyOtherContainerOpen
                      ? size.height * 0.45
                      : size.height * 0.15,
                  duration: const Duration(milliseconds: 500),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (_, pos) {
                        return Card(
                          elevation: 4,
                          color: AppColors.scaffoldBgColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                color: AppColors.scaffoldBgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 5,
                                child: Image.network(
                                  WeatherIcon.weatherIcon(
                                      dailyWeather.weather.icon),
                                  fit: BoxFit.fill,
                                  height: size.width * 0.09,
                                  width: size.width * 0.09,
                                ),
                              ),
                              verticalGap(4),
                              Text(
                                otherWeatherDetails.entries.elementAt(pos).key,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                              verticalGap(1),
                              Text(
                                  "${otherWeatherDetails.entries.elementAt(pos).value}",
                                  style: const TextStyle(fontSize: 10)),
                            ],
                          ),
                        );
                      },
                      itemCount: 9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
