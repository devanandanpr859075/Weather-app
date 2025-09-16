import 'dart:convert';

import '../model/weather_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiKey = '265c4a0a0f74bfb83036ceb59b8a50b0';

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch weather');
    }
  }

  Future<Weather> fetchWeatherByCity(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('City not found');
    }
  }
}
