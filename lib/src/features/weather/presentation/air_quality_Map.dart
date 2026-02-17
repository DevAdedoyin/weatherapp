import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/features/weather/data/repositories/air_quality_tile_provider.dart';

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
      transparency: 0.0,
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
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _position!,
            zoom: 11,
          ),
          tileOverlays: {_airQualityOverlay},
          onMapCreated: (controller) async {
            if (!_controller.isCompleted) _controller.complete(controller);

            if (!_cameraMoved) {
              _cameraMoved = true;
              await controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _position!, zoom: 11),
                ),
              );
            }
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ),
    );
  }
}
