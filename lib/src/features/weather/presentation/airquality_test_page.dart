import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/features/weather/data/datasources/air_quality_api.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/features/weather/data/repositories/air_quality_tile_provider.dart';
import '../../../common/gaps/sized_box.dart';
import '../../geo_location/repositories/address_repo.dart';
import '../domain/weather_tips_model.dart';

class AirQualityTest extends ConsumerStatefulWidget {
  const AirQualityTest({super.key});

  @override
  ConsumerState<AirQualityTest> createState() => _AirQualityTestState();
}

class _AirQualityTestState extends ConsumerState<AirQualityTest> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _position;
  bool _cameraMoved = false;

  @override
  void initState() {
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    if (_position == null) {
      return const LoadingIndicator();
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4, // IMPORTANT
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _position!,
              zoom: 14,
            ),
            onMapCreated: (controller) async {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }

              if (!_cameraMoved) {
                _cameraMoved = true;

                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _position!,
                      zoom: 16,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
