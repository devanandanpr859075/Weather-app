
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/location_service.dart';


class WeatherController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocationService _locationService = LocationService();

  Weather? weather;
  bool isLoading = false;
  String? error;

  Future<void> fetchWeatherByLocation() async {
    _setLoading(true);
    try {
      await _locationService.requestPermission();
      final location = await _locationService.getCurrentLocation();
      weather = await _apiService.fetchWeatherByLocation(location['lat']!, location['lon']!);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> fetchWeatherByCity(String city) async {
    _setLoading(true);
    try {
      weather = await _apiService.fetchWeatherByCity(city);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}