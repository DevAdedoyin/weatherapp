import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

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

class DailyForecastPage extends ConsumerStatefulWidget {
  const DailyForecastPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyForecastPageState();
}

class _DailyForecastPageState extends ConsumerState<DailyForecastPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    ref.watch(dailyWeatherProvider);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: size.height * 0.06, bottom: 5),
            child: Text("5 Days Forecast", style: textTheme.headlineMedium)),
        Text("Accurate Weather Forecast", style: textTheme.bodyMedium),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height:
                    size.height < 650 ? size.height * 0.6 : size.height * 0.75,
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
            } else if (!snapshot.hasData &&
                snapshot.connectionState != ConnectionState.waiting) {
              return SizedBox(
                height:
                    size.height < 650 ? size.height * 0.6 : size.height * 0.75,
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
            }
            final data = snapshot.data?.dailyWeather;
            return Expanded(
              child: ListView.builder(
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
                          style: textTheme.titleMedium,
                        ),
                        Card(
                          // elevation: 3,
                          color: isDarkMode
                              ? AppColors.cardDarkModeColor
                              : AppColors.cardLightModeColor,
                          child: InkWell(
                            onTap: FirebaseAuth.instance.currentUser == null
                                ? () {
                              infoAuthAlertWidget(
                                  context,
                                  "Please kindly login or create an account to see more forecast details",
                                  "LOGIN REQUIRED", onTap: () {
                                context.go(AppRoutes.login);
                              });
                            }
                                : () {
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

                                    ref
                                        .read(dailyWeatherProvider.notifier)
                                        .state = dailyDetail;

                                    context.push(AppRoutes.dailyDetails);
                                  },
                            radius: 0.5,
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.white12 : Colors.black12,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.network(WeatherIcon.weatherIcon(
                                    data[pos].weather.icon)),
                              ),
                              title: Text(data[pos].weather.description,
                                  style: textTheme.bodyMedium),
                              subtitle: Text(data[pos].summary,
                                  style: const TextStyle(fontSize: 12)),
                              trailing: Text("${data[pos].temp.day.round()}°c",
                                  style: textTheme.bodyMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: data?.length,
              ),
            );
          },
          future: WeatherApiDataSource.fetchWeather(),
        ),
      ],
    );
  }
}
