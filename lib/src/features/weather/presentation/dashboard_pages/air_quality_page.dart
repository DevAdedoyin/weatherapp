import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/features/weather/data/datasources/air_quality_api.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/features/weather/data/repositories/air_quality_tile_provider.dart';
import '../../../../common/gaps/sized_box.dart';
import '../../domain/weather_tips_model.dart';

class AirQuality extends ConsumerStatefulWidget {
  const AirQuality({super.key});

  @override
  ConsumerState<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends ConsumerState<AirQuality> {
  late double latitude;
  late double longitude;

  late Future airQualityFuture;
  late TileOverlay tileOverlay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    airQualityFuture = fetchAirQuality();

    final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY']!;

    tileOverlay = TileOverlay(
      tileOverlayId: const TileOverlayId("aqHeatmap"),
      tileProvider: AirQualityTileProvider(apiKey, "US_AQI"),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: airQualityFuture,
        builder: (_, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: false,
                  floating: true,
                  pinned: true,
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
                    background: Container(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: size.height * 0.15,
                        child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                          target: LatLng(GLOBAL_CURRENT_LATITUDE,
                              GLOBAL_CURRENT_LONGITUDE),
                          zoom: 1,
                        )
                            // tileOverlays: {
                            //  tileOverlay
                            // },
                            ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (!snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Unable to fetch data. Please try again.",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Refresh",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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
                  const Text("Loading your air quality data")
                ],
              ),
            );
          }
        });
  }
}
