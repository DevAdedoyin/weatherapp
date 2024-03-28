import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";

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
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 5),
            child: Text("7 Days Forecast", style: textTheme.displayMedium)),
        const Text("Accurate Weather Forecast",
            style: TextStyle(
              fontSize: 12,
            )),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            final data = snapshot.data?.dailyWeather;
            return Expanded(
              child: ListView.builder(
                itemBuilder: (_, pos) {
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      data![pos].dateTime * 1000);
                  final formattedDate =
                      DateFormat('EEEE, d MMMM').format(dateTime);

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          textAlign: TextAlign.start,
                        ),
                        Card(
                          elevation: 5,
                          color: AppColors.scaffoldBgColor,
                          child: ListTile(
                            leading: Card(
                              elevation: 10,
                              color: AppColors.scaffoldBgColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.network(WeatherIcon.weatherIcon(
                                  data[pos].weather.icon)),
                            ),
                            title: Text(
                              data[pos].weather.description,
                            ),
                            subtitle: Text(data[pos].summary,
                                style: TextStyle(
                                  fontSize: 10,
                                )),
                            trailing: Text("${data[pos].temp.day.round()}°c",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
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
