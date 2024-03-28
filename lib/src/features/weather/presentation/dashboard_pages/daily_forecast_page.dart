import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";

class DailyForecastPage extends ConsumerStatefulWidget {
  const DailyForecastPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyForecastPageState();
}

class _DailyForecastPageState extends ConsumerState<DailyForecastPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        child: Column(
      children: [
        Text("15 Days Forecast", style: textTheme.displayMedium),
        const Text("Accurate Weather Forecast"),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            final data = snapshot.data?.dailyWeather;
            return ListView.builder(
              itemBuilder: (_, pos) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Friday, 28 July",
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
                                data![pos].weather.icon)),
                          ),
                          title: Text(
                            data[pos].weather.description,
                          ),
                          subtitle: Text(data[pos].summary),
                          trailing: Text("${data[pos].temp.day.round()}"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: data?.length,
            );
          },
          future: WeatherApiDataSource.fetchWeather(),
        )
      ],
    ));
  }
}
