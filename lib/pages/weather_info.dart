import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:our_love/providers/weather_provider.dart';

class WeatherInfoPage extends StatelessWidget {
  const WeatherInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 Consumer 来获取最新的 WeatherProvider 状态
    return Scaffold(
      appBar: AppBar(title: const Text('天气详情')),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          // 复用和 home.dart 页面类似的逻辑来显示内容

          // 情况 1: 正在加载
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 情况 2: 出现错误
          if (weatherProvider.errorMessage != null) {
            return Center(
              child: Text(
                '加载失败: ${weatherProvider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 情况 3: 没有天气数据
          if (weatherProvider.weatherData == null) {
            return const Center(child: Text('没有可用的天气数据。'));
          }

          // 情况 4: 成功获取数据
          if (weatherProvider.weatherData!.lives.isEmpty) {
            return const Center(child: Text('未获取到具体天气信息。'));
          }
          final liveWeather = weatherProvider.weatherData!.lives.first;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${liveWeather.province} ${liveWeather.city}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('更新于: ${liveWeather.reporttime}'),
                    const Divider(height: 30),
                    ListTile(
                      leading: const Icon(Icons.thermostat, color: Colors.red),
                      title: const Text('温度'),
                      trailing: Text(
                        '${liveWeather.temperature}°C',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.cloud, color: Colors.blue),
                      title: const Text('天气现象'),
                      trailing: Text(
                        liveWeather.weather,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.air, color: Colors.green),
                      title: const Text('风向'),
                      trailing: Text(
                        liveWeather.winddirection,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.speed, color: Colors.grey),
                      title: const Text('风力'),
                      trailing: Text(
                        '${liveWeather.windpower} 级',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.water_drop,
                        color: Colors.lightBlue,
                      ),
                      title: const Text('湿度'),
                      trailing: Text(
                        '${liveWeather.humidity}%',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
