// 导入 Flutter 的 Material 包，因为我们需要用到 ChangeNotifier。
import 'package:flutter/material.dart';
// 导入 SharedPreferences 用于数据持久化
import 'package:shared_preferences/shared_preferences.dart';
// 导入您的用户服务，用于调用登录API
import 'package:our_love/api/services/user_service.dart';
// 导入我们新创建的 UserModel
import 'package:our_love/models/user_model.dart';

// ===================================================================
// 2. 创建状态管理类 (Provider / ChangeNotifier)
// ===================================================================
// 这是我们的核心状态管理类，负责管理用户的认证状态。
// 它混入（with）了 ChangeNotifier，这意味着它可以向监听它的 Widget 发出通知。
class AuthProvider with ChangeNotifier {
  // ------------------- 私有状态变量 (Private State) -------------------

  // 使用下划线 `_` 开头表示这是一个私有变量，只能在 AuthProvider 类内部访问。
  // 这样做可以保护状态不被外部随意修改，所有修改都必须通过我们提供的公共方法来进行。

  // `_user` 用于存储当前登录的用户信息。初始值为 null，表示没有用户登录。
  UserModel? _user;

  // `_isLoggedIn` 用于标记用户是否已登录。初始值为 false。
  bool _isLoggedIn = false;

  // ------------------- 公共获取器 (Public Getters) -------------------

  // Getter 是一种特殊的方法，让外部可以安全地“读取”私有状态的值，但不能修改。

  // `user` getter，外部可以通过 `authProvider.user` 来获取当前用户信息。
  UserModel? get user => _user;

  // `isLoggedIn` getter，外部可以通过 `authProvider.isLoggedIn` 来检查登录状态。
  bool get isLoggedIn => _isLoggedIn;

  // ------------------- 公共方法 (Public Methods) -------------------

  // 这些方法是外部世界与我们的状态交互的唯一途径。

  /// `login` 方法：处理用户登录的业务逻辑。
  /// 它现在会调用真实的API，并在成功后持久化登录状态。
  /// 返回一个布尔值，true 表示登录成功，false 表示失败。
  Future<bool> login(String yierNumber, String password) async {
    try {
      // 1. 调用您写好的 UserService.login 方法发起网络请求
      final response = await UserService.login(yierNumber, password);

      // 2. 检查服务器返回的状态码和业务码
      //    按照最佳实践，业务状态码应该为数字类型
      if (response.statusCode == 200 && response.data['code'] == 0) {
        // 3. 根据后端返回的正确数据结构解析 token 和 user 数据
        //    后端数据结构: { "result": { "token": "...", "user": { ... } } }
        final resultData = response.data['result'];
        final String token = resultData['token'];
        final Map<String, dynamic> userData = resultData['user'];

        // 4. 更新内存中的状态
        // 使用 UserModel 的 fromJson 工厂构造函数来解析用户数据
        _user = UserModel.fromJson(userData);
        _isLoggedIn = true;

        // 5. 【持久化】获取 SharedPreferences 实例
        final prefs = await SharedPreferences.getInstance();
        // 6. 【持久化】将 token 保存到设备上
        await prefs.setString('auth_token', token);

        // 7. 通知UI刷新
        notifyListeners();
        return true; // 返回登录成功
      } else {
        // 服务器返回了非200的状态码，表示业务逻辑上的失败（如密码错误）
        print('登录失败: ${response.data}');
        return false;
      }
    } catch (e) {
      // 捕获网络请求或其他异常
      print('登录异常: $e');
      return false;
    }
  }

  /// `logout` 方法：处理用户登出的逻辑。
  Future<void> logout() async {
    // 1. 将所有内存状态重置为初始值。
    _user = null;
    _isLoggedIn = false;

    // 2. 【持久化】获取 SharedPreferences 实例
    final prefs = await SharedPreferences.getInstance();
    // 3. 【持久化】从设备上删除已保存的 token
    await prefs.remove('auth_token');

    // 4. 通知UI刷新
    notifyListeners();
  }

  /// `tryAutoLogin` 方法：在应用启动时尝试自动登录。
  /// 这个方法应该在 main.dart 中，应用启动时调用一次。
  Future<bool> tryAutoLogin() async {
    // 1. 【持久化】获取 SharedPreferences 实例
    final prefs = await SharedPreferences.getInstance();

    // 2. 【持久化】尝试从设备读取 token
    final String? token = prefs.getString('auth_token');

    // 3. 如果没有 token，说明用户从未登录或已登出，直接返回 false
    if (token == null) {
      return false;
    }

    // 4. 如果有 token，说明用户之前登录过。
    //    在真实应用中，您应该在这里发起一个API请求（例如 /user/profile）来验证 token 的有效性，
    //    并获取最新的用户信息。
    //    这里我们为了简化，直接认为有 token 就是登录成功。

    // 5. 模拟通过 token 获取用户信息
    // 在真实场景中，这里应该调用API获取用户信息，然后使用 UserModel.fromJson
    // 为了演示，我们创建一个模拟的 UserModel 对象
    _user = UserModel.fromJson({
      "id": 999,
      "yier_number": "cached_user",
      "password": "cached_password",
      "name": "自动登录用户",
      "manifest_consistent_whether": false,
      "is_admin": false,
      "point": 0,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
    _isLoggedIn = true;

    // 6. 通知UI刷新
    notifyListeners();
    return true;
  }
}
