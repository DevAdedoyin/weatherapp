import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_mobile_ads/google_mobile_ads.dart";

import "package:intl/intl.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/features/weather/data/repositories/daily_detail_repo.dart";
import "package:weatherapp/src/features/weather/domain/daily_detail_model.dart";

import "package:weatherapp/src/routing/app_routes.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";

import "../../../../common/widgets/auth_widgets/info_alert.dart";
import "../../../../utils/daily_limit_checker.dart";
import "../../../ads/ad_counter.dart";
import "../../../ads/data/repositories/banner_repository.dart";
import "../../../ads/data/repositories/interstital_repository.dart";
import "../../../temeperature_scale/data/temperature_data.dart";

class DailyForecastPage extends ConsumerStatefulWidget {
  const DailyForecastPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyForecastPageState();
}

class _DailyForecastPageState extends ConsumerState<DailyForecastPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdDisplayCounter.addDisplayCounter(
        ref.read(interstitialAdProvider.notifier),
        adPoint: 1.5);
    // TODO NOTE
    // In the future to load ad banners uncomment this code
    ref.read(forecastBannerAdProvider.notifier).loadAd();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    final bannerAd = ref.watch(forecastBannerAdProvider);
    ref.watch(dailyWeatherProvider);
    final user = FirebaseAuth.instance.currentUser;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: size.height * 0.075, bottom: 5),
            child: Text(
              user == null ? "5 Days Forecast" : "7 Days Forecast",
              style: GoogleFonts.aboreto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        Text("Accurate Weather Forecast",
            style: GoogleFonts.acme(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white70)),
        verticalGap(10),
        if (bannerAd != null)
          SizedBox(
            height: bannerAd.size.height.toDouble(),
            width: size.width * 0.90,
            child: AdWidget(ad: bannerAd),
          ),
        verticalGap(5),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height:
                    size.height < 650 ? size.height * 0.55 : size.height * 0.6,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoadingIndicator(),
                    verticalGap(5),
                    Text("Loading your weather data",
                        style: GoogleFonts.acme(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70))
                  ],
                ),
              );
            } else if (!snapshot.hasData &&
                snapshot.connectionState != ConnectionState.waiting) {
              return SizedBox(
                height:
                    size.height < 650 ? size.height * 0.6 : size.height * 0.65,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Unable to fetch data. Please try again.",
                        style: GoogleFonts.acme(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        "Refresh",
                      ),
                    )
                  ],
                ),
              );
            }
            final data = snapshot.data?.dailyWeather;
            return Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (_, pos) {
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      data![pos].dateTime.toInt() * 1000);
                  final formattedDate =
                      DateFormat('EEEE, d MMMM').format(dateTime);
                  final currData = data[pos];

                  return Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 0, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.acme(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Card(
                          // elevation: 3,
                          color: isDarkMode
                              ? AppColors.cardDarkModeColor
                              : AppColors.cardLightModeColor,
                          child: InkWell(
                            onTap: () async {
                              bool isDailyLimitReached =
                                  await DailyLimitChecker.checkDailyLimit();
                              if (FirebaseAuth.instance.currentUser == null &&
                                  isDailyLimitReached) {
                                AdDisplayCounter.addDisplayCounter(
                                    ref.read(interstitialAdProvider.notifier),
                                    adPoint: 2);
                                infoAuthAlertWidget(
                                    context,
                                    "Please kindly login or create an account to see more details.",
                                    "Daily Limit Reached", onTap: () {
                                  context.go(AppRoutes.login);
                                });
                              } else {
                                final dailyDetail = DailyDetailModel(
                                    dateTime: formattedDate,
                                    temp: currData.temp,
                                    feelsLike: currData.feelsLike,
                                    pressure: currData.pressure,
                                    moonrise: currData.moonrise,
                                    moonset: currData.moonset,
                                    summary: currData.summary,
                                    sunrise: currData.sunrise,
                                    sunset: currData.sunset,
                                    humidity: currData.humidity,
                                    dewPoint: currData.dewPoint,
                                    windSpeed: currData.windSpeed,
                                    windDegree: currData.windDegree,
                                    weather: currData.weather);

                                ref.read(dailyWeatherProvider.notifier).state =
                                    dailyDetail;

                                if (FirebaseAuth.instance.currentUser == null) {
                                  AdDisplayCounter.addDisplayCounter(
                                      ref.read(interstitialAdProvider.notifier),
                                      adPoint: 2);
                                } else {
                                  AdDisplayCounter.addDisplayCounter(
                                      ref.read(interstitialAdProvider.notifier),
                                      adPoint: 1.5);
                                }

                                context.push(AppRoutes.dailyDetails);
                              }
                            },
                            radius: 0.5,
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white12
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.network(WeatherIcon.weatherIcon(
                                    data[pos].weather.icon)),
                              ),
                              title: Text(data[pos].weather.description,
                                  style: textTheme.bodyMedium),
                              subtitle: Text(data[pos].summary,
                                  style: const TextStyle(fontSize: 12)),
                              trailing: FutureBuilder<String>(
                                future: TemperatureConverter.formatWithPrefs(
                                  data[pos].temp.day.toDouble(),
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    snapshot.data!,
                                    style: GoogleFonts.acme(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: user == null ? 5 : data?.length,
              ),
            );
          },
          future: WeatherApiDataSource.fetchWeather(),
        ),
      ],
    );
  }
}
