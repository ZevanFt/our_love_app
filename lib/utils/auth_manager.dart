/// AuthManager 类用于管理应用的认证状态，提供登录、登出和检查登录状态的功能。
/// 该类使用静态方法和属性，确保在整个应用中可以全局访问认证状态。
class AuthManager {
  /// 私有静态变量，用于存储用户的登录状态。
  /// `true` 表示用户已登录，`false` 表示用户未登录。
  static bool _isLoggedIn = false;

  /// 静态 getter 方法，用于获取用户的登录状态。
  /// 返回当前的登录状态，方便在应用的其他部分检查用户是否已登录。
  static bool get isLoggedIn => _isLoggedIn;

  /// 静态方法，用于处理用户登录操作。
  /// 调用此方法时，将 `_isLoggedIn` 标志设置为 `true`，表示用户已成功登录。
  static void login() {
    _isLoggedIn = true;
  }

  /// 静态方法，用于处理用户登出操作。
  /// 调用此方法时，将 `_isLoggedIn` 标志设置为 `false`，表示用户已退出登录。
  static void logout() {
    _isLoggedIn = false;
  }
}
