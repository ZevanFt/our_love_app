import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:our_love/providers/auth_provider.dart';
import 'package:our_love/providers/weather_provider.dart';
import 'package:our_love/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  // 定义渐变色常量
  static const maleGradient = LinearGradient(
    colors: [Color(0xFFf2e7ea), Color(0xFFe3eefe)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const femaleGradient = LinearGradient(
    colors: [Color(0xFFe7dee9), Color(0xFFfccbf1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 根据性别获取渐变色的辅助方法
  LinearGradient _getGradientForSex(String? sex) {
    if (sex == '男') {
      return maleGradient;
    } else if (sex == '女') {
      return femaleGradient;
    }
    return maleGradient; // 默认男性
  }

  @override
  Widget build(BuildContext context) {
    // 同时监听 AuthProvider 和 WeatherProvider
    return Consumer2<AuthProvider, WeatherProvider>(
      builder: (context, authProvider, weatherProvider, child) {
        final user = authProvider.user;
        final hasMate = user?.mateId != null;

        // 获取本人的渐变色
        final userGradient = _getGradientForSex(user?.sex);
        // 伴侣的渐变色与本人相反
        final mateGradient = (user?.sex == '男') ? femaleGradient : maleGradient;

        final liveWeather = weatherProvider.weatherData?.lives.firstOrNull;
        final locationData = weatherProvider.locationData;

        String city, district, street, weather, temperature;

        if (weatherProvider.isLoading) {
          city = '加载中...';
          district = '...';
          street = '加载中...';
          weather = '加载中...';
          temperature = '加载中...';
        } else if (weatherProvider.errorMessage != null) {
          city = '加载失败';
          district = '请重试';
          street = '-----';
          weather = ':(';
          temperature = '-----';
        } else if (liveWeather != null && locationData != null) {
          city = locationData.addressComponent.city;
          district = locationData.addressComponent.district;
          street = locationData.addressComponent.streetNumber.street;
          weather = liveWeather.weather;
          temperature = '${liveWeather.temperature}°C';
        } else {
          city = locationData?.addressComponent.city ?? '未知';
          district = locationData?.addressComponent.district ?? '地区';
          street = locationData?.addressComponent.streetNumber.street ?? '';
          weather = '暂无数据';
          temperature = '...';
        }

        const topBorderRadius = BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        );
        const bottomBorderRadius = BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        );

        return FractionallySizedBox(
          widthFactor: 1.0,
          child: Column(
            children: [
              // 本人天气卡片
              _buildWeatherRow(
                context,
                icon: Icons.person_pin_circle,
                city: city,
                district: district,
                street: street,
                weather: weather,
                temperature: temperature,
                gradient: userGradient,
                borderRadius: topBorderRadius,
              ),
              // 根据是否有伴侣显示不同内容
              if (hasMate)
                _buildWeatherRow(
                  context,
                  icon: Icons.favorite,
                  city: '武汉市', // TODO: 这里需要获取伴侣的城市信息
                  district: '洪山区',
                  street: '碧桂园十里春风',
                  weather: '多云',
                  temperature: '5~2°C',
                  gradient: mateGradient,
                  borderRadius: bottomBorderRadius,
                )
              else
                _buildLinkMateCard(context, mateGradient, bottomBorderRadius),
            ],
          ),
        );
      },
    );
  }

  // 链接伴侣提示卡片
  Widget _buildLinkMateCard(
    BuildContext context,
    Gradient gradient,
    BorderRadius borderRadius,
  ) {
    return GestureDetector(
      onTap: () => context.go('/about_me'),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/love_record.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '请先链接伴侣',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'SW-Kai', // 添加字体设置
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '^v^快去邀请伴侣加入吧！',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'SW-Kai', // 添加字体设置
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('', style: Theme.of(context).textTheme.titleMedium),
                Text('', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(width: 16),
            Icon(Icons.arrow_forward_ios, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherRow(
    BuildContext context, {
    required IconData icon,
    required String city,
    required String district,
    required String street,
    required String weather,
    required String temperature,
    Gradient? gradient,
    BorderRadius? borderRadius,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(gradient: gradient, borderRadius: borderRadius),
      child: Row(
        children: [
          SvgPicture.asset(
            'lib/assets/icons/svg/locate.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$city $district',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'SW-Kai', // 添加字体设置
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (street.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    street,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'SW-Kai', // 添加字体设置
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else ...[
                  const SizedBox(height: 4),
                  Text(
                    '---',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'SW-Kai', // 添加字体设置
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                weather,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'SW-Kai', // 添加字体设置
                ),
              ),
              Text(
                temperature,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'SW-Kai', // 添加字体设置
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const Icon(Icons.ac_unit, color: Colors.lightBlueAccent),
        ],
      ),
    );
  }
}
