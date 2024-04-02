import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/geo_location/repositories/address_repo.dart";
// import "package:weatherapp/src/features/geo_location/data/get_location.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/features/weather/data/repositories/hourly_weather_detail.dart";
import "package:weatherapp/src/features/weather/data/repositories/search_city_repo.dart";
// import "package:weatherapp/src/features/weather/domain/ho_model.dart";
import "package:weatherapp/src/features/weather/domain/weather_model.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/routing/app_routes.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? address = "";

  @override
  void initState() {
    super.initState();

    getAddress();
    ref.read(currentAddress.notifier).state = address!;
    // ref.read(isFromSearchScreen.notifier).state = false;
  }

  String getDateTime() {
    var now = DateTime.now();

    String formattedDateTime = DateFormat('d MMMM, EEEE HH:mm').format(now);

    return formattedDateTime;
  }

  void getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    address = prefs.getString("address");
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
    ref.watch(currentAddress);
    ref.watch(isFromSearchScreen);
    return FutureBuilder<WeatherModel>(
        future: WeatherApiDataSource.fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            print("ADDRESS $address");
            final data = snapshot.data;
            print("DATA: ${snapshot.data}");
            final sunrise = DateTime.fromMillisecondsSinceEpoch(
                data!.currentWeatherModel.sunrise * 1000);
            final sunset = DateTime.fromMillisecondsSinceEpoch(
                data.currentWeatherModel.sunset * 1000);
            String formattedSunrise = DateFormat('HH:mm a').format(sunrise);
            String formattedSunset = DateFormat('HH:mm a').format(sunset);

            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: AppColors.scaffoldBgColor,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$address",
                        // textAlign: TextAlign.center,
                        style: textTheme.titleMedium,
                      ),
                      verticalGap(3),
                      Text(
                        getDateTime(),
                        style: textTheme.titleSmall,
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
                  expandedHeight: size.height * 0.3,
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
                        // height: size.width * 0.20,
                        // width: size.width * 0.20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
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
                            data.currentWeatherModel.weather.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 30, fontWeight: FontWeight.w500),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pressure",
                                      style: textTheme.titleSmall,
                                    ),
                                    Text(
                                      "${data.currentWeatherModel.pressure}",
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunrise",
                                      style: textTheme.titleSmall,
                                    ),
                                    Text(formattedSunrise),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: textTheme.titleSmall,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Wind Speed",
                                      style: textTheme.titleSmall,
                                    ),
                                    Text(
                                        "${data.currentWeatherModel.windSpeed}km/h"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunset",
                                      style: textTheme.titleSmall,
                                    ),
                                    Text(formattedSunset),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dew Point",
                                      style: textTheme.titleSmall,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Next 10 hours',
                            style: textTheme.titleMedium,
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
                                final data_ = data.hourlyWeather[position];
                                var date = DateFormat.Hm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        data_.dateTime * 1000));
                                return InkWell(
                                  onTap: () {
                                    final hourlyState = ref
                                        .read(hourlyWeatherDetails.notifier)
                                        .state;
                                    hourlyState.date =
                                        DateFormat('d MMMM, EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                data_.dateTime * 1000));
                                    hourlyState.time = DateFormat('h a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            data_.dateTime * 1000));
                                    hourlyState.desctiption =
                                        data_.weather.description;
                                    hourlyState.dewPoint =
                                        data_.dewPoint.round().toString();
                                    hourlyState.feelsLike =
                                        data_.feelsLike.round().toString();
                                    hourlyState.humidity =
                                        data_.humidity.toString();
                                    hourlyState.image = data_.weather.icon;
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
                                    hourlyState.isFromSearch = false;
                                    hourlyState.address = address!;
                                    context
                                        .push(AppRoutes.hourlyWeatherDetails);
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  radius: 0.5,
                                  child: Container(
                                    width: size.width * 0.42,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Card(
                                      color: AppColors.scaffoldBgColor,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          verticalGap(5),
                                          Text(date.toString(),
                                              style: textTheme.titleMedium),
                                          verticalGap(3),
                                          Text(
                                            data_.weather.description,
                                            style: textTheme.titleSmall,
                                          ),
                                          verticalGap(2),
                                          const Divider(
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                              color: AppColors.primaryColor),
                                          Hero(
                                            tag: "weather-image-$position",
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
                                                fontWeight: FontWeight.w700),
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
          } else {
            return const LoadingIndicator();
          }
        });
  }
}
