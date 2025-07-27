import 'package:dio/dio.dart';
import 'package:our_love/api/clients/dio_client.dart';

class LocationService {
  static final Dio _dio = DioClient().dio;

  // 定位（经纬度）转地址
  static Future<Response> getAddress(double latitude, double longitude) async {
    try {
      final Response response = await _dio.get(
        '/location/address',
        queryParameters: {'latitude': latitude, 'longitude': longitude},
      );
      return response;
    } catch (e) {
      throw Exception('定位转地址失败：$e');
    }
  }
}
