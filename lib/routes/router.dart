// 引入所需的包
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_love/providers/auth_provider.dart';
// 登录页面
import 'package:our_love/pages/login.dart';
// 主页面
import 'package:our_love/pages/home.dart';
import 'package:our_love/pages/more_tool.dart';
import 'package:our_love/pages/todo.dart';
import 'package:our_love/pages/store.dart';
import 'package:our_love/pages/about_me.dart';
// 主体框架
import 'package:our_love/widget/main_scaffold.dart';
// 其他页面
import 'package:our_love/pages/product_edit.dart';
import 'package:our_love/pages/weather_info.dart';
import 'package:our_love/pages/wish_tree.dart';
import 'package:our_love/pages/anniversary.dart';
import 'package:our_love/pages/anniversary_detail.dart';
import 'package:our_love/pages/wife_demand.dart';
import 'package:our_love/pages/about_author.dart';
import 'package:our_love/pages/about_app.dart';
import 'package:our_love/pages/help_feedback.dart';
import 'package:our_love/pages/coupon_wallet_page.dart';
import 'package:our_love/pages/coupon_history_page.dart';

// 将 GoRouter 的创建封装在一个方法中，以便我们可以传递 refreshListenable
GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/home',
    // refreshListenable 告诉 GoRouter 在 authProvider 发出通知时重新评估路由。
    // 这是实现登录/登出后自动页面跳转的关键。
    refreshListenable: authProvider,
    redirect: (BuildContext context, GoRouterState state) {
      final bool isLoggedIn = authProvider.isLoggedIn;
      final bool isLoggingIn = state.matchedLocation == '/login';

      // 规则 1: 如果用户未登录，并且他们不在登录页面，则重定向到登录页面
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      // 规则 2: 如果用户已登录，但他们试图访问登录页面，则将他们重定向到主页
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }
      // 在所有其他情况下，不进行重定向
      return null;
    },
    routes: <RouteBase>[
      // 登录页面路由，任何人都可访问
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) {
          // 只在主页面显示底部导航栏和顶部AppBar
          return MainScaffold(child: child);
        },
        routes: [
          // 统一 / 和 /home 路径
          GoRoute(path: '/home', builder: (context, state) => const Home()),
          GoRoute(path: '/', redirect: (context, state) => '/home'),
          GoRoute(
            path: '/more_tool',
            builder: (context, state) => const MoreTool(),
          ),
          GoRoute(path: '/todo', builder: (context, state) => const TodoPage()),
          GoRoute(
            path: '/store',
            builder: (context, state) => const PointsStore(),
          ),
          GoRoute(
            path: '/about_me',
            builder: (context, state) => const AboutMe(),
          ),
        ],
      ),
      GoRoute(
        path: '/anniversary',
        builder: (BuildContext context, GoRouterState state) {
          return const AnniversaryPage();
        },
      ),
      GoRoute(
        path: '/wish_tree',
        builder: (BuildContext context, GoRouterState state) {
          return const WishTree();
        },
      ),
      // 天气详情
      GoRoute(
        path: '/weather_info',
        builder: (BuildContext context, GoRouterState state) {
          return const WeatherInfoPage();
        },
      ),
      // 纪念日详情
      GoRoute(
        path: '/anniversary_detail',
        builder: (context, state) {
          // 假设通过 state.extra 传递数据，根据实际情况修改
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return AnniversaryDetailPage(
            title: data['title'],
            date: data['date'],
            daysDiff: data['daysDiff'],
            description: data['description'],
            isRecurring: data['isRecurring'],
            type: data['type'],
            icon: data['icon'],
            color: data['color'],
          );
        },
      ),
      GoRoute(
        path: '/wife_demand',
        builder: (context, state) => const WifeDemandPage(),
      ),
      GoRoute(
        path: '/about_author',
        builder: (context, state) => const AboutAuthorPage(),
      ),
      GoRoute(
        path: '/about_app',
        builder: (context, state) => const AboutAppPage(),
      ),
      GoRoute(
        path: '/help_feedback',
        builder: (context, state) => const HelpFeedbackPage(),
      ),
      GoRoute(
        path: '/product_edit',
        builder: (context, state) => const ProductEditPage(),
      ),
      GoRoute(
        path: '/coupon_wallet',
        builder: (context, state) => const CouponWalletPage(),
      ),
      GoRoute(
        path: '/coupon_history',
        builder: (context, state) => CouponHistoryPage(),
      ),
    ],
  );
}
