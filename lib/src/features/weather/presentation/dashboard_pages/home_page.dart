import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart";
import "package:weatherapp/src/features/weather/domain/weather_model.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/utils/weather_icon_utils.dart";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      expandedHeight: size.height * 0.35,
                      collapsedHeight: size.height * 0.09,
                      toolbarHeight: size.height * 0.085,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          child: Image.network(
                            WeatherIcon.weatherIcon(
                              data!.currentWeatherModel.weather.icon,
                            ),
                            alignment: Alignment.center,
                            height: size.height * 0.20,
                            width: size.height * 0.20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalGap(0.5),
                            Text("${data?.timezone}"),
                            Text("Jul 2, 2021")
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        // color: Colors.blue[200],
                        height: 200, // Adjust height as needed
                        child: const Center(
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
