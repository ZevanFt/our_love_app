import 'package:flutter/material.dart';
import 'package:our_love/api/services/weather_service.dart';
import 'package:our_love/models/location_model.dart';
import 'package:our_love/models/weather_model.dart';
import 'package:our_love/utils/location_utils.dart'; // 假设你有一个获取经纬度的工具类

class WeatherProvider with ChangeNotifier {
  // 私有状态变量
  bool _isLoading = false;
  String? _errorMessage;
  LocationResponse? _locationData;
  WeatherForecastResponse? _weatherData;

  // 公共获取器
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LocationResponse? get locationData => _locationData;
  WeatherForecastResponse? get weatherData => _weatherData;

  // 核心方法：获取位置和天气
  Future<void> fetchWeatherAndLocation() async {
    // 1. 开始加载，清空旧数据和错误
    _isLoading = true;
    _errorMessage = null;
    _locationData = null;
    _weatherData = null;
    notifyListeners();

    try {
      // 2. 获取设备的经纬度
      final position = await LocationUtils.getCurrentLocation();

      // 如果获取位置失败（例如用户拒绝权限），则直接抛出错误并停止后续操作
      if (position == null) {
        throw Exception('获取地理位置失败，请检查定位权限和GPS服务。');
      }

      final geography = '${position.longitude},${position.latitude}';

      // 3. 使用经纬度获取位置信息 (adcode)
      final locationResponse = await WeatherService.getLocationInfo(geography);
      _locationData = locationResponse;
      notifyListeners(); // 获取到位置后可以先更新一次UI

      // 4. 使用 adcode 获取天气信息
      final adcode = locationResponse.addressComponent.adcode;
      final weatherResponse = await WeatherService.getWeatherInfo(adcode);
      _weatherData = weatherResponse;
    } catch (e) {
      // 5. 捕获任何步骤中发生的错误
      _errorMessage = e.toString();
    } finally {
      // 6. 结束加载状态
      _isLoading = false;
      notifyListeners();
    }
  }
}
