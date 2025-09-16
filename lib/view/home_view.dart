import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../controller/weather_controller.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherCtrl = Provider.of<WeatherController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Search Field
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.blue),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_controller.text.trim().isNotEmpty) {
                        weatherCtrl.fetchWeatherByCity(_controller.text.trim());
                      }
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: weatherCtrl.isLoading
                    ? const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 50),
                )
                    : weatherCtrl.error != null
                    ? Center(child: Text(weatherCtrl.error!, style: const TextStyle(color: Colors.red)))
                    : weatherCtrl.weather == null
                    ? const Center(child: Text('Search for a city or tap the location icon'))
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Weather Icon
                    Image.network(
                      'https://openweathermap.org/img/wn/${weatherCtrl.weather!.icon}@4x.png',
                      scale: 1.5,
                    ),

                    const SizedBox(height: 10),

                    // Temperature
                    Text(
                      '${weatherCtrl.weather!.temperature.toStringAsFixed(0)}°C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_outlined, size: 22),
                        const SizedBox(width: 6),
                        Text(
                          weatherCtrl.weather!.description,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Rain Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.water_drop_outlined, color: Colors.blue),
                        SizedBox(width: 6),
                        Text('Rain - 100%', style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // City Card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          weatherCtrl.weather!.city,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Location fetch button
      floatingActionButton: FloatingActionButton(
        onPressed: () => weatherCtrl.fetchWeatherByLocation(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
} 