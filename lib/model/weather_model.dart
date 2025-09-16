class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final double rainProbability;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.rainProbability,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final String description = json['weather'][0]['main'].toString();
    final double? rain1h = (json['rain']?['1h'] ?? json['rain']?['3h'])?.toDouble();

    return Weather(
      city: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: description,
      icon: json['weather'][0]['icon'],
      rainProbability: _mapRainToPercentage(description, rain1h),
    );
  }

  /// Helper to convert rain description or value to percentage
  static double _mapRainToPercentage(String desc, double? rainValue) {
    if (rainValue != null) {
      // OpenWeatherMap provides rain in mm — we estimate % out of a rough scale.
      return (rainValue * 10).clamp(0, 100);
    }

    switch (desc.toLowerCase()) {
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return 90;
      case 'clouds':
        return 20;
      case 'clear':
        return 0;
      default:
        return 10;
    }
  }
}
