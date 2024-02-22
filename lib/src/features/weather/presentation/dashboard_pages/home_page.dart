import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
// import "package:weatherapp/src/features/geo_location/data/get_location.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
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

    String formattedDateTime = DateFormat('MMM d, yyyy HH:mm').format(now);

    return formattedDateTime;
  }

  void getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    address = prefs.getString("address");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return FutureBuilder<WeatherModel>(
        future: WeatherApiDataSource.fetchWeather(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return snapshot.connectionState == ConnectionState.waiting
              ? LoadingIndicator()
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      snap: false,
                      floating: true,
                      pinned: true,
                      centerTitle: true,
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
                            data!.currentWeatherModel.weather.icon,
                          ),
                          alignment: Alignment.center,
                          height: size.height * 0.20,
                          width: size.height * 0.20,
                          fit: BoxFit.contain,
                        ),
                        title: Container(
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              verticalGap(0.5),
                              Text(
                                "$address",
                                textAlign: TextAlign.center,
                                style: textTheme.displaySmall,
                              ),
                              verticalGap(3),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  width: size.width * 0.3,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  // color:
                                  //     AppColors.accentColor.withOpacity(0.75),
                                  child: Text(
                                    getDateTime(),
                                    style: textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    colors: [
                                      Colors.white,
                                      Colors.grey,
                                      Colors.white,
                                    ],
                                  ),
                                  Text(
                                    "Feel like: ${data.currentWeatherModel.feelsLike.round()}°",
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
                        // color: Colors.blue[200],
                        height: 200, // Adjust height as needed
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Pressure"),
                                    Text("${data.currentWeatherModel.pressure}"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Dew Point"),
                                    Text(
                                        "${data.currentWeatherModel.dewPoint.round()}°c"),
                                  ],
                                ),
                                 Column(
                                  children: [
                                    Text("Humidity"),
                                    Text(
                                        "${data.currentWeatherModel.humidity}°c"),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [],
                                ),
                                Column(
                                  children: [],
                                ),
                                Column(
                                  children: [],
                                )
                              ],
                            ),
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
                  ],
                );
        });
  }
}
