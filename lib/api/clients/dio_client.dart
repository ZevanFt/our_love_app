import 'package:dio/dio.dart';
import 'package:our_love/config/environment.dart';
import 'package:our_love/config/env_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  // 私有构造函数，用于创建 DioClient 单例实例（单例模式）
  DioClient._internal() {
    // 创建 Dio 实例
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        // --- 请求拦截 ---
        onRequest: (options, handler) async {
          // 在发送请求前，异步获取 SharedPreferences 实例
          final prefs = await SharedPreferences.getInstance();
          // 尝试从本地存储中读取 token
          final String? token = prefs.getString('auth_token');

          // 如果 token 存在，则将其添加到请求头中
          if (token != null) {
            // 通常，token 会以 "Bearer " 为前缀
            options.headers['Authorization'] = 'Bearer $token';
          }

          // 打印请求头，方便调试
          print('Request Headers: ${options.headers}');

          // 继续执行请求
          return handler.next(options);
        },
        // --- 响应拦截 (可选) ---
        onResponse: (response, handler) {
          // 可以在这里对响应数据进行统一处理
          return handler.next(response);
        },
        // --- 错误拦截 (可选) ---
        onError: (DioException e, handler) {
          // 打印详细的错误信息
          print('Dio Error: $e');
          if (e.response != null) {
            print('Error Response data: ${e.response?.data}');
            print('Error Response headers: ${e.response?.headers}');
          } else {
            print('Error sending request: ${e.message}');
          }
          // 可以在这里对网络错误进行统一处理，例如 token 失效时跳转到登录页
          return handler.next(e);
        },
      ),
    );

    // 添加日志拦截器，确保它在我们的自定义拦截器之后，这样才能打印出包含 token 的请求头
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: true, // 打印请求头
        responseBody: true, // 打印响应体
      ),
    );
  }

  factory DioClient() {
    // 返回单例实例，确保在整个应用中只有一个 DioClient 实例被创建和访问
    return _instance;
  }

  // 获取 Dio 实例的 getter 方法
  Dio get dio => _dio;
}
