// 1. 导入我们需要的库
import 'dart:async';
import 'dart:io' show Platform;
import 'package:geolocator/geolocator.dart';

// 2. 创建一个名为 LocationUtils 的工具类来存放我们的方法
class LocationUtils {
  // ----------------- 从 main.dart 移动过来的权限请求函数 -----------------

  /// 请求定位权限。
  /// 这个方法应该在应用启动时（比如在 main 函数里）调用一次。
  /// static 关键字让我们可以直接通过类名调用，如：LocationUtils.requestPermission()
  static Future<void> requestPermission() async {
    // 检查权限状态
    LocationPermission permission = await Geolocator.checkPermission();

    // 如果权限是“被拒绝”状态，则发起一次新的请求
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // 如果用户在弹窗中再次拒绝，并且选择了“不再询问”
      if (permission == LocationPermission.deniedForever) {
        // 这种情况我们通常无能为力，只能打印日志或提示用户去设置里手动开启
        print('定位权限被永久拒绝，请手动开启');
      }
    }
  }

  /// 获取设备当前的精确位置。
  /// 这是一个可以在任何地方调用的、完整的定位功能。
  /// 它返回一个 Future，最终结果要么是 Position 对象，要么是 null。
  /// static 关键字让我们可以直接通过类名调用，如：LocationUtils.getCurrentLocation()
  static Future<Position?> getCurrentLocation() async {
    try {
      // 第一步：检查手机的定位服务总开关是否打开
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('定位服务未启用');
        return null;
      }

      // 第二步：检查 App 是否已被授予权限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('定位权限被拒绝');
        // 如果权限被拒，可以尝试再次请求，或者直接返回失败
        // 为了通用性，这里我们直接返回 null，让调用方决定是否要再次弹窗请求
        return null;
      }

      // 第三步：如果检查都通过，则获取当前位置
      print('正在获取当前位置...');

      LocationSettings locationSettings;
      const timeLimit = Duration(seconds: 15);

      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          timeLimit: timeLimit,
          intervalDuration: const Duration(seconds: 10),
        );
      } else if (Platform.isIOS || Platform.isMacOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          timeLimit: timeLimit,
          showBackgroundLocationIndicator: false,
        );
      } else {
        locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          timeLimit: timeLimit,
        );
      }

      // 使用正确的 locationSettings 并处理超时
      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } on TimeoutException {
      print('获取位置超时，请检查网络或GPS信号');
      return null;
    } catch (e) {
      // 捕获任何可能的异常
      print('获取位置时发生未知错误: $e');
      return null;
    }
  }
}
