import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/geo_location/data/get_location.dart';
import 'package:weatherapp/src/features/geo_location/repositories/address_repo.dart';
import 'package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart';
import 'package:weatherapp/src/features/weather/data/repositories/hourly_weather_detail.dart';
import 'package:weatherapp/src/features/weather/data/repositories/search_city_repo.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/utils/weather_icon_utils.dart';

class SearchDetailScreen extends ConsumerStatefulWidget {
  const SearchDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<SearchDetailScreen> {
  String? address = "";

  String getDateTime() {
    var now = DateTime.now();

    String formattedDateTime = DateFormat('d MMMM, EEEE HH:mm').format(now);

    return formattedDateTime;
  }

  void getAddress() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // ref.read(searchedAddress.notifier).state =
    //     prefs.getString("searchedAddress")!;
  }

  List<String> getNextTenHours() {
    List<String> hours = [];
    DateTime now = DateTime.now();

    for (int i = 1; i <= 10; i++) {
      DateTime nextHour = now.add(Duration(hours: i));
      String hourString =
          "${nextHour.hour.toString().padLeft(2, '0')}:${nextHour.minute.toString().padLeft(2, '0')}";
      hours.add(hourString);
    }

    return hours;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ref.watch(hourlyWeatherDetails);
    final searchedCity = ref.watch(searchCity);
    // final searchedLocationName = ref.watch(searchedALocation);

    // print("SEARCHING ${ref.read(searchedALocation.notifier).state}");
    return Scaffold(
      body: FutureBuilder<WeatherModel>(
          future: WeatherApiDataSource.searchedWeather(
              city: "${searchedCity["city"]}"),
          builder: (context, snapshot) {
            final data = snapshot.data;
            // print("DATA: ${snapshot.data}");
            final currentDateTime = DateTime.fromMillisecondsSinceEpoch(
                data!.currentWeatherModel.dateTime * 1000);
            final timeZoneAdded =
                currentDateTime.add(Duration(seconds: data.timezoneOffset));
            String formattedDateTime =
                DateFormat('d MMMM, EEEE HH:mm').format(timeZoneAdded);
            final sunrise = DateTime.fromMillisecondsSinceEpoch(
                data.currentWeatherModel.sunrise * 1000);
            final sunset = DateTime.fromMillisecondsSinceEpoch(
                data.currentWeatherModel.sunset * 1000);
            String formattedSunrise = DateFormat('HH:mm a').format(sunrise);
            String formattedSunset = DateFormat('HH:mm a').format(sunset);

            return snapshot.connectionState == ConnectionState.waiting
                ? const LoadingIndicator()
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: AppColors.scaffoldBgColor,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userSearchedAddress,
                              // textAlign: TextAlign.center,
                              style: textTheme.displaySmall,
                            ),
                            verticalGap(3),
                            Text(
                              formattedDateTime,
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        snap: false,
                        floating: true,
                        pinned: true,
                        // centerTitle: true,
                        // backgroundColor: AppColors.accentColor.withOpacity(0.05),
                        elevation: 5,
                        expandedHeight: size.height * 0.32,
                        collapsedHeight: size.height * 0.09,
                        // toolbarHeight: size.height * 0.085,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          background: Container(
                            color: AppColors.scaffoldBgColor,
                            child: Image.network(
                              WeatherIcon.weatherIcon(
                                data.currentWeatherModel.weather.icon,
                              ),
                              filterQuality: FilterQuality.high,
                              // alignment: Alignment.bottomCenter,
                              height: size.width * 0.30,
                              width: size.width * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.only(top: 0),
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GradientText(
                                      "${data.currentWeatherModel.temp.round()}°",
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
                                      "Feel like: ${data.currentWeatherModel.feelsLike.round()}°c",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.40,
                                // color: Colors.blue[200],
                                // Adjust height as needed
                                child: Text(
                                  data.currentWeatherModel.weather.description,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 25),
                          child: Card(
                            color: AppColors.scaffoldBgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Pressure",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              "${data.currentWeatherModel.pressure}"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Sunrise",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(formattedSunrise),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Humidity",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              "${data.currentWeatherModel.humidity}%"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                verticalGap(15),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Wind Speed",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              "${data.currentWeatherModel.windSpeed}km/h"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Sunset",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(formattedSunset),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Dew Point",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              "${data.currentWeatherModel.dewPoint.round()}°c"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Next 10 hours',
                                  style: textTheme.displaySmall,
                                ),
                              ),
                              verticalGap(10),
                              SizedBox(
                                height: size.height * 0.30,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.hourlyWeather.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int position) {
                                      final data_ =
                                          data.hourlyWeather[position];
                                      var date = DateFormat.Hm().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              data_.dateTime * 1000));
                                      return InkWell(
                                        onTap: () {
                                          final hourlyState = ref
                                              .read(
                                                  hourlyWeatherDetails.notifier)
                                              .state;
                                          hourlyState.date = DateFormat(
                                                  'd MMMM, EEEE')
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      data_.dateTime * 1000));
                                          hourlyState.time = DateFormat('h a')
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      data_.dateTime * 1000));
                                          hourlyState.desctiption =
                                              data_.weather.description;
                                          hourlyState.dewPoint =
                                              data_.dewPoint.round().toString();
                                          hourlyState.feelsLike = data_
                                              .feelsLike
                                              .round()
                                              .toString();
                                          hourlyState.humidity =
                                              data_.humidity.toString();
                                          hourlyState.image =
                                              data_.weather.icon;
                                          hourlyState.location = address;
                                          hourlyState.pressure =
                                              data_.pressure.toString();
                                          hourlyState.temp =
                                              data_.temp.round().toString();
                                          hourlyState.visibility =
                                              data_.visibility.toString();
                                          hourlyState.windDegree =
                                              data_.windDegree.toString();
                                          hourlyState.windGust =
                                              data_.windGust.toString();
                                          hourlyState.windSpeed =
                                              data_.windSpeed.toString();
                                          hourlyState.position = position;
                                          context.push(
                                              AppRoutes.hourlyWeatherDetails);
                                        },
                                        borderRadius: BorderRadius.circular(15),
                                        radius: 0.5,
                                        child: Container(
                                          width: size.width * 0.42,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Card(
                                            color: AppColors.scaffoldBgColor,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                verticalGap(5),
                                                Text(
                                                  date.toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                verticalGap(3),
                                                Text(data_.weather.description),
                                                verticalGap(2),
                                                const Divider(
                                                    thickness: 1,
                                                    indent: 10,
                                                    endIndent: 10,
                                                    color:
                                                        AppColors.primaryColor),
                                                Hero(
                                                  tag:
                                                      "weather-image-$position",
                                                  child: Image.network(
                                                    WeatherIcon.weatherIcon(
                                                      data_.weather.icon,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${data_.temp.round()}°c",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 27,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                verticalGap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),

                      // DAILY WEATHER
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Next 7 Days',
                                  style: textTheme.displaySmall,
                                ),
                              ),
                              verticalGap(7),
                              SizedBox(
                                height: size.height * 0.30,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.dailyWeather.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int position) {
                                      final data_ = data.dailyWeather[position];
                                      var date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              data_.dateTime * 1000);
                                      final formattedTime =
                                          DateFormat.Hm().format(date);
                                      final dayOfWeek =
                                          DateFormat('EEEE').format(date);
                                      return InkWell(
                                        onTap: () {
                                          // final hourlyState = ref
                                          //     .read(
                                          //         hourlyWeatherDetails.notifier)
                                          //     .state;
                                          // hourlyState.date = DateFormat(
                                          //         'd MMMM, EEEE')
                                          //     .format(DateTime
                                          //         .fromMillisecondsSinceEpoch(
                                          //             data_.dateTime * 1000));
                                          // hourlyState.time = DateFormat('h a')
                                          //     .format(DateTime
                                          //         .fromMillisecondsSinceEpoch(
                                          //             data_.dateTime * 1000));
                                          // hourlyState.desctiption =
                                          //     data_.weather.description;
                                          // hourlyState.dewPoint =
                                          //     data_.dewPoint.round().toString();
                                          // hourlyState.feelsLike = data_
                                          //     .feelsLike
                                          //     .round()
                                          //     .toString();
                                          // hourlyState.humidity =
                                          //     data_.humidity.toString();
                                          // hourlyState.image =
                                          //     data_.weather.icon;
                                          // hourlyState.location = address;
                                          // hourlyState.pressure =
                                          //     data_.pressure.toString();
                                          // hourlyState.temp =
                                          //     data_.temp.round().toString();
                                          // hourlyState.visibility =
                                          //     data_.visibility.toString();
                                          // hourlyState.windDegree =
                                          //     data_.windDegree.toString();
                                          // hourlyState.windGust =
                                          //     data_.windGust.toString();
                                          // hourlyState.windSpeed =
                                          //     data_.windSpeed.toString();
                                          // hourlyState.position = position;
                                          // context.push(
                                          //     AppRoutes.hourlyWeatherDetails);
                                        },
                                        borderRadius: BorderRadius.circular(15),
                                        radius: 0.5,
                                        child: Container(
                                          width: size.width * 0.42,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Card(
                                            color: AppColors.scaffoldBgColor,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                verticalGap(5),
                                                Text(
                                                  dayOfWeek,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                verticalGap(3),
                                                Text(data_.weather.description),
                                                verticalGap(2),
                                                const Divider(
                                                    thickness: 1,
                                                    indent: 10,
                                                    endIndent: 10,
                                                    color:
                                                        AppColors.primaryColor),
                                                Hero(
                                                  tag:
                                                      "weather-image-$position",
                                                  child: Image.network(
                                                    WeatherIcon.weatherIcon(
                                                      // "",
                                                      data_.weather.icon,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // "",
                                                  "${data_.temp.day.round()}°c",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 27,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                verticalGap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
