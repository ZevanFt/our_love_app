import 'package:dio/dio.dart';
import 'package:our_love/api/clients/dio_client.dart';

// 用户服务类封装
class UserService {
  // Dio 实例，从 dio_client 获取，已包含 baseURL
  static final Dio _dio = DioClient().dio;
  // 定义所有用户相关接口的统一前缀
  static const String _prefix = '/user';

  // 登录方法
  static Future<Response> login(String yierNumber, String password) async {
    // 定义请求的相对路径
    const String path = '$_prefix/login';
    // 定义请求的数据
    final Map<String, dynamic> data = {
      'yier_number': yierNumber,
      'password': password,
    };

    // 打印详细的调试信息
    print('--- [UserService] 发起登录请求 ---');
    print('请求方式: POST');
    // DioClient 的 baseURL 已经配置好，这里打印相对路径和完整URL
    print('请求路径 (相对): $path');
    print('请求路径 (完整): ${_dio.options.baseUrl}$path');
    print('请求 Body: $data');
    print('------------------------------------');

    try {
      // 使用前面定义的变量发起请求
      final Response response = await _dio.post(path, data: data);
      // 打印成功响应
      print('--- [UserService] 收到登录响应 ---');
      print('状态码: ${response.statusCode}');
      print('响应数据: ${response.data}');
      print('------------------------------------');
      return response;
    } catch (e) {
      // 如果是 DioError，可以打印更详细的错误信息
      if (e is DioException) {
        print('--- [UserService] 登录请求异常 (DioError) ---');
        print('错误类型: ${e.type}');
        print('错误信息: ${e.message}');
        if (e.response != null) {
          print('服务器响应状态码: ${e.response?.statusCode}');
          print('服务器响应数据: ${e.response?.data}');
        }
        print('---------------------------------------------');
      } else {
        print('--- [UserService] 登录请求发生未知异常 ---');
        print('异常详情: $e');
        print('---------------------------------------------');
      }
      // 重新抛出异常，让上层（AuthProvider）可以捕获
      rethrow;
    }
  }

  // 获取用户信息方法
  static Future<Response> getUserProfile() async {
    // 定义请求的相对路径
    const String path = '$_prefix/profile';

    // 打印详细的调试信息
    print('--- [UserService] 发起获取用户信息请求 ---');
    print('请求方式: GET');
    print('请求路径 (相对): $path');
    print('请求路径 (完整): ${_dio.options.baseUrl}$path');
    print('------------------------------------');

    try {
      // 发起 GET 请求，Dio 拦截器会自动附加 token
      final Response response = await _dio.get(path);
      // 打印成功响应
      print('--- [UserService] 收到获取用户信息响应 ---');
      print('状态码: ${response.statusCode}');
      print('响应数据: ${response.data}');
      print('------------------------------------');
      return response;
    } catch (e) {
      // 如果是 DioError，可以打印更详细的错误信息
      if (e is DioException) {
        print('--- [UserService] 获取用户信息请求异常 (DioError) ---');
        print('错误类型: ${e.type}');
        print('错误信息: ${e.message}');
        if (e.response != null) {
          print('服务器响应状态码: ${e.response?.statusCode}');
          print('服务器响应数据: ${e.response?.data}');
        }
        print('---------------------------------------------');
      } else {
        print('--- [UserService] 获取用户信息请求发生未知异常 ---');
        print('异常详情: $e');
        print('---------------------------------------------');
      }
      // 重新抛出异常，让上层（AuthProvider）可以捕获
      rethrow;
    }
  }

  // 注册方法
  static Future<Response> register(String yierNumber, String password) async {
    try {
      // 使用前缀拼接完整的请求路径
      final Response response = await _dio.post(
        '$_prefix/register',
        data: {'yier_number': yierNumber, 'password': password},
      );
      return response;
    } catch (e) {
      throw Exception('注册失败：$e');
    }
  }
}
