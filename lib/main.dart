// 导入 Flutter Material 包
import 'package:flutter/material.dart';
// 导入 provider 包，这样我们才能使用 ChangeNotifierProvider
import 'package:provider/provider.dart';
// 导入我们需要的 Provider
import 'package:our_love/providers/auth_provider.dart';
import 'package:our_love/providers/weather_provider.dart';
// 引入路由配置
import 'package:our_love/routes/router.dart';
// 引入定位工具类，以便在应用启动时请求权限
import 'package:our_love/utils/location_utils.dart';

// main 函数是应用的入口点
void main() async {
  // 将 main 函数改为 async
  // 确保 Flutter 的绑定已经初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 在应用启动时就请求定位权限，这是一个好的实践
  await LocationUtils.requestPermission();

  // runApp 函数启动应用
  runApp(
    // 使用 MultiProvider 来提供多个状态管理器
    MultiProvider(
      providers: [
        // 1. 提供 AuthProvider 用于认证
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..tryAutoLogin(),
        ),
        // 2. 提供 WeatherProvider 用于天气功能
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      // `child` 属性就是我们的应用本身。
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 通过 Provider.of 获取 AuthProvider 的实例。
    //    这会建立一个依赖关系，当 AuthProvider 变化时，这个 Widget 会重建。
    final authProvider = Provider.of<AuthProvider>(context);

    // 2. 调用我们在 router.dart 中创建的函数，并传入 authProvider。
    //    这样，路由配置就能访问到登录状态了。
    final router = createAppRouter(authProvider);

    // 3. 将动态生成的 router 实例传递给 MaterialApp.router。
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Our Love',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: const TextStyle(fontFamily: 'SW-Kai'),
          displayLarge: const TextStyle(fontFamily: 'SW-Kai'),
          displayMedium: const TextStyle(fontFamily: 'SW-Kai'),
        ),
        // 设置全局 Scaffold 背景颜色为白色
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: router,
    );
  }
}
