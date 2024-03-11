import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
// import "package:weatherapp/src/features/geo_location/data/get_location.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/features/weather/domain/hourly_weather_model.dart";
import "package:weatherapp/src/features/weather/domain/weather_model.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
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
    return FutureBuilder<WeatherModel>(
        future: WeatherApiDataSource.fetchWeather(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final sunrise = DateTime.fromMillisecondsSinceEpoch(
              data!.currentWeatherModel.sunrise * 1000);
          final sunset = DateTime.fromMillisecondsSinceEpoch(
              data.currentWeatherModel.sunset * 1000);
          String formattedSunrise = DateFormat('HH:mm a').format(sunrise);
          String formattedSunset = DateFormat('HH:mm a').format(sunset);

          return snapshot.connectionState == ConnectionState.waiting
              ? LoadingIndicator()
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: AppColors.scaffoldBgColor,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$address",
                            // textAlign: TextAlign.center,
                            style: textTheme.displaySmall,
                          ),
                          verticalGap(3),
                          Text(
                            getDateTime(),
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
                      elevation: 20,
                      expandedHeight: size.height * 0.35,
                      collapsedHeight: size.height * 0.09,
                      toolbarHeight: size.height * 0.085,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        background: Image.network(
                          WeatherIcon.weatherIcon(
                            data.currentWeatherModel.weather.icon,
                          ),
                          alignment: Alignment.center,
                          height: size.height * 0.20,
                          width: size.height * 0.20,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          color: AppColors.cardBgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
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
                                          style: TextStyle(color: Colors.grey),
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
                                          style: TextStyle(color: Colors.grey),
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
                                          style: TextStyle(color: Colors.grey),
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
                                          style: TextStyle(color: Colors.grey),
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
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text("$formattedSunset"),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Dew Point",
                                          style: TextStyle(color: Colors.grey),
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
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                    final data_ = data.hourlyWeather[position];
                                    var date = DateFormat.Hm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            data_.dateTime * 1000));
                                    return Container(
                                      width: size.width * 0.42,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Card(
                                        color: AppColors.cardBgColor,
                                        elevation: 2,
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
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            verticalGap(3),
                                            position == 0
                                                ? Text(
                                                    "Next ${position + 1} hr")
                                                : Text(
                                                    "Next ${position + 1} hrs"),
                                            verticalGap(2),
                                            Divider(
                                                thickness: 3,
                                                indent: 10,
                                                endIndent: 10,
                                                color: AppColors.primaryColor),
                                            Image.network(
                                              WeatherIcon.weatherIcon(
                                                data_.weather.icon,
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
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        // color: Colors.blue[200],
                        height: 200, // Adjust height as needed
                        child: Center(
                          child: Text('Custom Widget Here'),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        // color: Colors.blue[200],
                        height: 200, // Adjust height as needed
                        child: Center(
                          child: Text('Custom Widget Here'),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
