import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/features/weather/data/repositories/air_quality_tile_provider.dart';
import 'package:weatherapp/src/features/weather/domain/air_quality_model/air_quality_index_table.dart';

import '../../../common/gaps/sized_box.dart';
import '../../geo_location/repositories/address_repo.dart';

class AirQualityMap extends ConsumerStatefulWidget {
  const AirQualityMap({super.key});

  @override
  ConsumerState<AirQualityMap> createState() => _AirQualityMapState();
}

class _AirQualityMapState extends ConsumerState<AirQualityMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? _position;
  bool _cameraMoved = false;
  late final TileOverlay _airQualityOverlay;

  @override
  void initState() {
    super.initState();

    // Get user location from Riverpod provider
    Future.microtask(() {
      final latlng = ref.read(latlngAQIState);
      final lat = latlng['lat'];
      final lon = latlng['lon'];

      if (lat != null && lon != null) {
        setState(() {
          _position = LatLng(lat, lon);
        });
      }
    });

    // Create TileOverlay for air quality
    _airQualityOverlay = TileOverlay(
      tileOverlayId: const TileOverlayId('air_quality_heatmap'),
      tileProvider: AirQualityTileProvider(
        dotenv.env['REACT_APP_GOOGLE_API_KEY'] ?? '',
        "US_AQI",
      ),
      transparency: 0.2,
    );
  }

  void _showAqiInfo(Size size) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Know Your AQI Scale",
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 20),
        contentPadding: EdgeInsets.all(5),
        content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: airQualityIndexChart.length,
                itemBuilder: (_, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(airQualityIndexChart[index].airQualityStatus),
                          SizedBox(
                            child: Divider(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.white24,
                              indent: size.width * 0.001,
                              endIndent: size.width * 0.001,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text("Colour"),
                                  verticalGap(1),
                                  Text(
                                    airQualityIndexChart[index].color,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text("AQI Range"),
                                  verticalGap(1),
                                  Text(
                                    airQualityIndexChart[index].indexValue,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: size.height * 0.04,
                              color: airQualityIndexChart[index].rgb,
                            ),
                          ),
                          Text(
                            airQualityIndexChart[index].description,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_position == null) {
      return const LoadingIndicator();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.37,
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              buildingsEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId("user"),
                  position: _position!,
                  infoWindow: const InfoWindow(title: "You're somewhere here"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ),
              },
              initialCameraPosition: CameraPosition(
                target: _position!,
                zoom: 13,
              ),
              tileOverlays: {_airQualityOverlay},
              onMapCreated: (controller) async {
                if (!_controller.isCompleted) _controller.complete(controller);

                if (!_cameraMoved) {
                  _cameraMoved = true;
                  await controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: _position!, zoom: 13),
                    ),
                  );
                }
              },
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),
            Positioned(
              top: 12,
              right: 12,
              child: FloatingActionButton.small(
                backgroundColor: Colors.blue,
                heroTag: "aqiInfo",
                onPressed: () {
                  _showAqiInfo(size);
                },
                child: const Icon(CupertinoIcons.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
