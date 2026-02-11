import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AirQualityTileProvider implements TileProvider {
  final String apiKey;
  final String mapType;

  AirQualityTileProvider(this.apiKey, this.mapType);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final url =
        "https://airquality.googleapis.com/v1/mapTypes/$mapType/heatmapTiles/$zoom/$x/$y?key=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      return Tile(256, 256, bytes);
    }
    return TileProvider.noTile;
  }
}
