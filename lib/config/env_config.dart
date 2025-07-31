import 'package:our_love/config/environment.dart';

// 环境配置管理类
// 实现不同环境下的服务地址配置

// 环境配置管理类
// 定义应用运行环境及对应服务地址
class EnvironmentConfig {
  // 当前环境类型（默认为开发环境）
  static late final Environment _currentEnv;

  // static late final Environment _currentEnv = Environment.development;

  // 统一的 baseURL
  static String get apiBaseUrl {
    switch (_currentEnv) {
      case Environment.development:
        // 对于 Android 模拟器，使用 10.0.2.2 来访问宿主机（电脑）的 localhost
        return 'http://10.0.2.2:8100';
      case Environment.staging:
        return 'http://47.76.101.175:8100/';
      case Environment.production:
        return 'http://47.76.101.175:8100';
    }
  }

  static final Map<Environment, Map<ApiService, String>> _serviceUrls = {
    // 开发环境的服务地址配置
    Environment.development: {
      // 对于 Android 模拟器，使用 10.0.2.2 来访问宿主机（电脑）的 localhost
      ApiService.base: 'http://10.0.2.2:8100', // 基础服务API地址
    },
    // 预发布环境的服务地址配置
    Environment.staging: {
      ApiService.base: 'http://47.76.101.175:8100/', // 基础服务API地址
    },
    // 生产环境的
    Environment.production: {
      ApiService.base: 'http://47.76.101.175:8100/', // 基础服务API地址
    },
  };

  // 设置当前环境
  /// 设置当前应用的运行环境
  /// [env] 要设置的目标环境，类型为 [Environment]
  /// 若传入的环境在 _serviceUrls 中无对应配置，会抛出异常
  static void setEnvironment(Environment env) {
    // 检查 _serviceUrls 映射中是否包含传入的环境类型作为键
    // 若包含，说明该环境已配置服务地址，可进行设置
    if (_serviceUrls.containsKey(env)) {
      // 将当前环境设置为传入的环境类型
      _currentEnv = env;
    } else {
      // 若不包含，说明该环境未配置，抛出参数错误异常
      throw ArgumentError('Unsupported environment: $env');
    }
  }

  // 获取当前环境的服务地址
  /// 获取当前环境下指定服务的 API 地址
  /// [service] 需要获取 API 地址的服务类型，类型为 [ApiService]
  /// 返回值为 [String] 类型的 API 地址
  /// 若当前环境未配置该服务的 API 地址，会抛出异常
  static String getServiceUrl(ApiService service) {
    // 从 _serviceUrls 映射中根据当前环境 _currentEnv 和指定服务 service 获取对应的 API 地址
    // 使用 ?. 操作符避免空指针异常，若获取不到则返回 null
    // 若获取结果为 null，使用 ?? 操作符抛出 ArgumentError 异常
    return _serviceUrls[_currentEnv]?[service] ??
        (throw ArgumentError('Service not configured for current environment'));
  }

  /// 获取当前应用的运行环境类型
  /// 返回值为 [Environment] 类型，表示当前应用所处的环境
  static Environment get currentEnvironment => _currentEnv;

  /// static：静态方法意味着无需创建 EnvironmentConfig 类的实例即可调用

  /// 动态更新服务URL（用于调试/测试）
  /// 该方法允许在运行时修改指定环境下特定服务的API地址，主要用于调试和测试场景。
  /// [env] 要更新服务URL的目标环境，类型为 [Environment]，必须提供。
  /// [service] 要更新URL的具体服务类型，类型为 [ApiService]，必须提供。
  /// [newUrl] 服务的新API地址，类型为 [String]，必须提供。
  static void updateServiceUrl({
    required Environment env,
    required ApiService service,
    required String newUrl,
  }) {
    // 确保环境已存在于 _serviceUrls 映射中
    // 若指定的环境不存在，则在 _serviceUrls 中为该环境创建一个空的服务映射
    if (!_serviceUrls.containsKey(env)) {
      _serviceUrls[env] = {};
    }

    // 更新指定环境下特定服务的URL
    // 由于前面已经确保了 _serviceUrls[env] 存在，所以使用 ! 操作符来解包
    _serviceUrls[env]![service] = newUrl;
  }
}
