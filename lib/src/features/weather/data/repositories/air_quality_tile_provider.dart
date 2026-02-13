import 'dart:typed_data';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AirQualityTileProvider implements TileProvider {
  final String apiKey;
  final String layerName;

  AirQualityTileProvider(this.apiKey, this.layerName);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    if (zoom == null) return TileProvider.noTile;

    // Make sure x and y are integers (they already are from Google Maps)
    final url =
        'https://airquality.googleapis.com/v1/mapTypes/$layerName/heatmapTiles/$zoom/$x/$y?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Tile(256, 256, response.bodyBytes);
      } else {
        print('Tile request failed: ${response.statusCode}, URL: $url');
        return TileProvider.noTile;
      }
    } catch (e) {
      print('Error fetching tile: $e');
      return TileProvider.noTile;
    }
  }
}
