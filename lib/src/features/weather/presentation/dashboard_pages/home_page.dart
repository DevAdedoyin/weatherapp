import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_mobile_ads/google_mobile_ads.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/ads/ad_counter.dart";
import "package:weatherapp/src/features/geo_location/repositories/address_repo.dart";

// import "package:weatherapp/src/features/geo_location/data/get_location.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/features/weather/data/repositories/hourly_weather_detail.dart";
import "package:weatherapp/src/features/weather/data/repositories/search_city_repo.dart";
import "package:weatherapp/src/features/weather/data/repositories/weather_tips.dart";

// import "package:weatherapp/src/features/weather/domain/ho_model.dart";
import "package:weatherapp/src/features/weather/domain/weather_model.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/features/weather/domain/weather_tips_model.dart";
import "package:weatherapp/src/routing/app_routes.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import "../../../../common/widgets/auth_widgets/info_alert.dart";
import "../../../ads/data/repositories/banner_repository.dart";
import "../../../ads/data/repositories/interstital_repository.dart";
import "../../../temeperature_scale/data/temperature_data.dart";
import "../../../weather_fact/weather_fact_data.dart";
// import 'package:shimmer/shimmer.dart';

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
    // TODO: PUSH NEW DATA TO PLAYSTORE
    // addWeatherFacts();
    getAddress();

    AdDisplayCounter.addDisplayCounter(
        ref.read(interstitialAdProvider.notifier));
    // ref.read(userCurrentAddress.notifier).state = address!;
    // ref.read(isFromSearchScreen.notifier).state = false;

    ref.read(bannerAdProvider.notifier).loadAd();
    ref.read(banner2AdProvider.notifier).loadAd();
  }

  String getDateTime() {
    var now = DateTime.now();

    String formattedDateTime = DateFormat('d MMMM, EEEE HH:mm').format(now);

    return formattedDateTime;
  }

  void getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    address = prefs.getString("address");

    ref.read(userCurrentAddress.notifier).state = address!;
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

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bannerAd = ref.watch(bannerAdProvider);
    final banner2Ad = ref.watch(banner2AdProvider);
    ref.watch(hourlyWeatherDetails);
    ref.watch(currentAddress);
    ref.watch(userCurrentAddress);
    ref.watch(isFromSearchScreen);
    ref.watch(weatherId);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    TextTheme textTheme = Theme.of(context).textTheme;
    // print("Size ${size.height}");

    final user = FirebaseAuth.instance.currentUser;

    final name =
        user == null || user.isAnonymous ? "" : (user.displayName ?? "");

    return FutureBuilder<WeatherModel>(
        future: WeatherApiDataSource.fetchWeather(),
        builder: (context, snapshot) {
          // print("snap data ${snapshot.data}");
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            // print("ADDRESS $address");
            final data = snapshot.data;
            // print("DATA: ${snapshot.data}");
            final sunrise = DateTime.fromMillisecondsSinceEpoch(
                data!.currentWeatherModel.sunrise.toInt() * 1000);
            final sunset = DateTime.fromMillisecondsSinceEpoch(
                data.currentWeatherModel.sunset.toInt() * 1000);
            String formattedSunrise = DateFormat('HH:mm a').format(sunrise);
            String formattedSunset = DateFormat('HH:mm a').format(sunset);
            Future.delayed(
                Duration(milliseconds: 10),
                () => ref.read(weatherId.notifier).state =
                    data.currentWeatherModel.weather.id);
            double wId = data.currentWeatherModel.weather.id;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // verticalGap(2),
                      Text(
                        "$address",
                        // textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      // verticalGap(2),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: isDarkMode ? Colors.red : Colors.blue),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Text(
                          getDateTime(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    FirebaseAuth.instance.currentUser == null
                        ? IconButton(
                            onPressed: () {
                              context.go(AppRoutes.userLocatorPage);
                            },
                            icon: Icon(
                              Icons.refresh,
                            ))
                        : Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Text(
                              name,
                              style: textTheme.titleSmall,
                            ),
                          )
                  ],
                  snap: false,
                  floating: true,
                  pinned: true,
                  // centerTitle: true,
                  // backgroundColor: AppColors.accentColor.withOpacity(0.05),
                  elevation: 5,
                  expandedHeight: size.height < 650
                      ? size.height * 0.30
                      : size.height * 0.30,
                  collapsedHeight: size.height < 650
                      ? size.height * 0.15
                      : size.height * 0.15,
                  toolbarHeight: size.height * 0.09,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    background:
                        // !isDarkMode
                        //     ? Container(
                        //         // color: Colors.black,
                        //         child: Image.network(
                        //           WeatherIcon.weatherIcon(
                        //               data.currentWeatherModel.weather.icon),
                        //           fit: BoxFit.cover,
                        //           filterQuality: FilterQuality.high,
                        //         ),
                        //       )
                        //     :
                        Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        WeatherImages.weatherImages(wId),
                        filterQuality: FilterQuality.high,
                        // alignment: Alignment.bottomCenter,
                        // height: size.width * 0.20,
                        // width: size.width * 0.20,
                        fit: BoxFit.contain,
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
                          width: size.width * 0.49,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                future: TemperatureConverter.formatWithPrefs(
                                    data.currentWeatherModel.temp.toDouble()),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox.shrink();
                                  }
                                  return GradientText(
                                    snapshot.data!,
                                    // already formatted with unit
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: size.height < 650 ? 60 : 80.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    colors: const [
                                      Colors.white,
                                      Colors.grey,
                                      Colors.white
                                    ],
                                  );
                                },
                              ),
                              FutureBuilder<String>(
                                future: TemperatureConverter.formatWithPrefs(
                                    data.currentWeatherModel.feelsLike
                                        .toDouble()),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    "Feel like: ${snapshot.data}",
                                    style: textTheme.titleSmall,
                                  );
                                },
                              ),
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
                            style: GoogleFonts.acme(
                                fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (bannerAd != null)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        verticalGap(20),
                        SizedBox(
                          height: bannerAd.size.height.toDouble(),
                          width: size.width * 0.90,
                          child: AdWidget(ad: bannerAd),
                        ),
                      ],
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    child: Card(
                      color: isDarkMode
                          ? AppColors.cardDarkModeColor
                          : AppColors.cardLightModeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: isDarkMode ? 3 : 1,
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
                                      style: textTheme.bodyMedium,
                                    ),
                                    Text(
                                      "${data.currentWeatherModel.pressure}",
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunrise",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Text(
                                      formattedSunrise,
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Text(
                                      "${data.currentWeatherModel.humidity}%",
                                      style: textTheme.bodySmall,
                                    ),
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
                                      style: textTheme.bodyMedium,
                                    ),
                                    Text(
                                      "${data.currentWeatherModel.windSpeed}m/s",
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunset",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Text(
                                      formattedSunset,
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dew Point",
                                      style: textTheme.bodyMedium,
                                    ),
                                    FutureBuilder<String>(
                                      future:
                                          TemperatureConverter.formatWithPrefs(
                                              data.currentWeatherModel.dewPoint
                                                  .toDouble()),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const SizedBox.shrink();
                                        }
                                        return Text(snapshot.data!,
                                            style: textTheme.bodySmall);
                                      },
                                    ),
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
                if (banner2Ad != null && user == null)
                  // if (banner2Ad != null)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        verticalGap(1),
                        SizedBox(
                          height: bannerAd?.size.height.toDouble(),
                          width: size.width * 0.90,
                          child: AdWidget(ad: banner2Ad),
                        ),
                      ],
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            user == null ? "Next 5 hours" : 'Next 24 hours',
                            style: textTheme.titleMedium,
                          ),
                        ),
                        verticalGap(8),
                        SizedBox(
                          height: size.height < 620
                              ? size.height * 0.38
                              : size.height < 650
                                  ? size.height * 0.45
                                  : size.height < 690
                                      ? size.height * 0.40
                                      : size.height * 0.30,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  user == null ? 5 : data.hourlyWeather.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                final data_ = data.hourlyWeather[position];
                                var date = DateFormat.Hm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        data_.dateTime.toInt() * 1000));
                                return InkWell(
                                  onTap: () {
                                    if (currentUser == null) {
                                      ref
                                          .read(interstitialAdProvider.notifier)
                                          .showAd();
                                      infoAuthAlertWidget(
                                          context,
                                          "Please kindly login or create an account to see more details.",
                                          "LOGIN REQUIRED", onTap: () {
                                        context.go(AppRoutes.login);
                                      });
                                    } else {
                                      final hourlyState = ref
                                          .read(hourlyWeatherDetails.notifier)
                                          .state;
                                      hourlyState.date =
                                          DateFormat('d MMMM, EEEE').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      data_.dateTime.toInt() *
                                                          1000));
                                      hourlyState.time = DateFormat('h a')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  data_.dateTime.toInt() *
                                                      1000));
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
                                      AdDisplayCounter.addDisplayCounter(
                                          ref.read(
                                              interstitialAdProvider.notifier));
                                    }
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
                                      color: isDarkMode
                                          ? AppColors.cardDarkModeColor
                                          : AppColors.cardLightModeColor,
                                      elevation: isDarkMode ? 3 : 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          verticalGap(
                                              size.height < 650 ? 2 : 5),
                                          Text(date.toString(),
                                              style: textTheme.titleMedium),
                                          verticalGap(
                                              size.height < 650 ? 1 : 3),
                                          Text(
                                            data_.weather.description,
                                            style: textTheme.titleSmall,
                                          ),
                                          verticalGap(2),
                                          Divider(
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                              color: isDarkMode
                                                  ? AppColors.primaryColor
                                                  : Colors.black12),
                                          Container(
                                            // padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? Colors.white12
                                                    : Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Hero(
                                              tag: "weather-image-$position",
                                              child: Image.network(
                                                WeatherIcon.weatherIcon(
                                                  data_.weather.icon,
                                                ),
                                              ),
                                            ),
                                          ),
                                          FutureBuilder<String>(
                                            future: TemperatureConverter
                                                .formatWithPrefs(
                                                    data_.temp.toDouble()),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const SizedBox.shrink();
                                              }
                                              return Text(
                                                snapshot.data!,
                                                style: GoogleFonts.roboto(
                                                  fontSize: size.height < 690
                                                      ? 22
                                                      : 25,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              );
                                            },
                                          ),
                                          verticalGap(
                                              size.height < 650 ? 2 : 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            print("UNABALE DATA: ${snapshot.error}");
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Unable to fetch data. Please try again.",
                    style: textTheme.titleSmall,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingIndicator(),
                  verticalGap(10),
                  const Text("Loading your weather data")
                ],
              ),
            );
          }
        });
  }
}
