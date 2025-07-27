import 'dart:convert';

// Helper function to decode the main object
WeatherForecastResponse weatherForecastResponseFromJson(String str) =>
    WeatherForecastResponse.fromJson(json.decode(str));

// Main response object for weather data
class WeatherForecastResponse {
  final String status;
  final String count;
  final String info;
  final String infocode;
  final List<Live> lives; // Changed from forecasts to lives

  WeatherForecastResponse({
    required this.status,
    required this.count,
    required this.info,
    required this.infocode,
    required this.lives, // Changed from forecasts to lives
  });

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) =>
      WeatherForecastResponse(
        status: json["status"] ?? '',
        count: json["count"] ?? '',
        info: json["info"] ?? '',
        infocode: json["infocode"] ?? '',
        // Check if 'lives' exists and is a list before mapping
        lives: json["lives"] != null && json["lives"] is List
            ? List<Live>.from(json["lives"].map((x) => Live.fromJson(x)))
            : [], // Default to an empty list if 'lives' is null or not a list
      );
}

// Live weather data object
class Live {
  final String province;
  final String city;
  final String adcode;
  final String weather;
  final String temperature;
  final String winddirection;
  final String windpower;
  final String humidity;
  final String reporttime;
  final String temperatureFloat;
  final String humidityFloat;

  Live({
    required this.province,
    required this.city,
    required this.adcode,
    required this.weather,
    required this.temperature,
    required this.winddirection,
    required this.windpower,
    required this.humidity,
    required this.reporttime,
    required this.temperatureFloat,
    required this.humidityFloat,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
    province: json["province"] ?? '',
    city: json["city"] ?? '',
    adcode: json["adcode"] ?? '',
    weather: json["weather"] ?? '',
    temperature: json["temperature"] ?? '',
    winddirection: json["winddirection"] ?? '',
    windpower: json["windpower"] ?? '',
    humidity: json["humidity"] ?? '',
    reporttime: json["reporttime"] ?? '',
    temperatureFloat: json["temperature_float"] ?? '',
    humidityFloat: json["humidity_float"] ?? '',
  );
}
