import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:our_love/providers/weather_provider.dart';
import 'package:our_love/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (weatherProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (weatherProvider.errorMessage != null) {
          return Text('天气加载失败: ${weatherProvider.errorMessage}');
        }

        if (weatherProvider.weatherData == null ||
            weatherProvider.weatherData!.lives.isEmpty) {
          return const Text('暂无天气信息');
        }

        final liveWeather = weatherProvider.weatherData!.lives.first;
        final locationData = weatherProvider.locationData;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildWeatherRow(
                  context,
                  icon: Icons.location_on,
                  city: locationData?.addressComponent.city ?? '未知',
                  district: locationData?.addressComponent.district ?? '地区',
                  weather: liveWeather.weather,
                  temperature: '${liveWeather.temperature}°C',
                  color: Colors.blue.shade100,
                ),
                const Divider(),
                // TODO: Add partner's weather info here
                _buildWeatherRow(
                  context,
                  icon: Icons.location_on,
                  city: '武汉市',
                  district: '洪山区',
                  weather: '多云',
                  temperature: '5~2°C',
                  color: Colors.pink.shade100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeatherRow(
    BuildContext context, {
    required IconData icon,
    required String city,
    required String district,
    required String weather,
    required String temperature,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$city $district',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // You can add a smaller text here if needed, like in the screenshot
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(weather, style: Theme.of(context).textTheme.titleMedium),
              Text(temperature, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(width: 16),
          // TODO: Add weather icon here
          const Icon(Icons.wb_sunny, color: Colors.orange),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
