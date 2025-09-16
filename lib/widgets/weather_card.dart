// import 'package:flutter/material.dart';
// import '../model/weather_model.dart';
//
// class WeatherCard extends StatelessWidget {
//   final Weather weather;
//   const WeatherCard({super.key, required this.weather});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             Text(
//               weather.city, // ✅ Matches your model
//               style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '${weather.temp.toStringAsFixed(1)}°C', // ✅ Use temp
//               style: const TextStyle(fontSize: 50),
//             ),
//             const SizedBox(height: 8),
//             const Text('Current weather', style: TextStyle(fontSize: 18)), // You can enhance with description if needed
//             const SizedBox(height: 16),
//             Image.network(
//               'https://openweathermap.org/img/wn/${weather.icon}@2x.png', // ✅ Use icon
//               scale: 0.8,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
