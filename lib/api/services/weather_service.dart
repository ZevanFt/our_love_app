import 'package:dio/dio.dart';
import 'package:our_love/api/clients/dio_client.dart';
import 'package:our_love/models/location_model.dart';
import 'package:our_love/models/weather_model.dart';

class WeatherService {
  static final Dio _dio = DioClient().dio;
  static const String _prefix = '/weather';

  /// 获取地理位置信息
  /// 你的后端接口是 POST /weather/location，并且需要一个 geography 参数
  /// 这里我们假设 geography 是一个经纬度字符串，例如 "114.48,30.46"
  static Future<LocationResponse> getLocationInfo(String geography) async {
    try {
      final response = await _dio.post(
        '$_prefix/location',
        // 后端需要从查询参数中获取 'geography'
        queryParameters: {'geography': geography},
      );
      // 将返回的 JSON 数据解码为我们的模型对象
      return LocationResponse.fromJson(response.data);
    } catch (e) {
      // 抛出异常，让上层 Provider 能够捕获并处理
      throw Exception('获取地理位置信息失败: $e');
    }
  }

  /// 根据 adcode 获取天气信息
  static Future<WeatherForecastResponse> getWeatherInfo(String adcode) async {
    try {
      final response = await _dio.get(
        '$_prefix/all',
        queryParameters: {'geography': adcode},
      );
      print(response.data);
      // 将返回的 JSON 数据解码为我们的模型对象
      return WeatherForecastResponse.fromJson(response.data);
    } catch (e) {
      // 抛出异常，让上层 Provider 能够捕获并处理
      throw Exception('获取天气信息失败: $e');
    }
  }
}
