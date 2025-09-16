import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;


class LocationService {
  Future<void> requestPermission() async {
    await Permission.location.request();
  }

  Future<Map<String, double>> getCurrentLocation() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'lat': (data['lat'] as num).toDouble(),
        'lon': (data['lon'] as num).toDouble(),
      };
    } else {
      throw Exception('Failed to get IP location');
    }
  }
}
