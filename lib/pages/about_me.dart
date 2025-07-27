// 导入 flutter material 包
import 'package:flutter/material.dart';
// 导入 provider 包，这样我们才能使用 context.watch 和 context.read
import 'package:provider/provider.dart';
// 导入我们之前创建的 AuthProvider
import 'package:our_love/providers/auth_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    // 在 build 方法的顶部，使用 context.watch<AuthProvider>() 来获取 AuthProvider 的实例。
    // `watch` 会“监听”这个 provider，当它调用 notifyListeners() 时，这个 build 方法会重新执行，从而刷新UI。
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yier壹贰',
          style: TextStyle(fontFamily: 'SW-Kai', fontSize: 18),
        ),
        actions: [
          IconButton(
            // 使用 SvgPicture.asset 加载 SVG 图标
            icon: SvgPicture.asset(
              'lib/assets/icons/svg/notice-1.svg',
              width: 24, // 设置图标宽度
              height: 24, // 设置图标高度
            ),
            color: Colors.black,
            onPressed: () {
              // context.pushNamed('settings');
              // 跳转到消息通知页面
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 将获取到的 authProvider 实例传递给 _buildProfileHeader 方法
                _buildProfileHeader(context, authProvider),
                _buildMoreFeatures(context),
                _buildAboutSection(context),
                // By且试新茶趁年华
                Container(
                  margin: const EdgeInsets.only(top: 7, bottom: 30),
                  child: const Center(
                    child: Text(
                      'By 且试新茶趁年华',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 修改方法签名，接收一个 AuthProvider 类型的参数
  Widget _buildProfileHeader(BuildContext context, AuthProvider authProvider) {
    final double width = MediaQuery.of(context).size.width * 0.95;
    return Container(
      width: width,
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink[200]!, Colors.blue[200]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // 使用 if-else 来根据登录状态显示不同的UI
        child: authProvider.isLoggedIn
            // === 如果已登录 (isLoggedIn is true) ===
            ? Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    // 可以使用用户的头像，如果 user 对象中有的话
                    // backgroundImage: NetworkImage(authProvider.user!.avatarUrl),
                    child: const Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 10),
                  // 显示用户名
                  Text(
                    '欢迎, ${authProvider.user!.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('退出登录'),
                    onPressed: () {
                      // 调用登出方法，注意这里使用 context.read，因为我们只是调用方法，不需要监听
                      context.read<AuthProvider>().logout();
                    },
                  ),
                ],
              )
            // === 如果未登录 (isLoggedIn is false) ===
            : Column(
                children: [
                  const Text(
                    '您尚未登录',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('点击登录'),
                    onPressed: () {
                      // 调用登录方法，同样使用 context.read
                      // 这里使用模拟数据，真实场景中会从输入框获取
                      context.read<AuthProvider>().login(
                        'user123',
                        'password123',
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMoreFeatures(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.95;
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: 0, right: 0, top: 7, bottom: 7),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),

      decoration: BoxDecoration(
        // color: const Color(0xFFF7F2FA),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: ListSection(
        titleStyle: const TextStyle(fontSize: 15, fontFamily: 'SW-Kai'),
        trailingIconColor: Colors.grey[400],
        items: [
          ListSectionItem(
            svgName: 'account_management.svg',
            title: '账号管理',
            path: '/account_management',
            onTap: () {
              context.push('/wish_tree');
            },
          ),
          ListSectionItem(
            svgName: 'home_page_management.svg',
            title: '首页管理',
            path: '/home_page_management',
            onTap: () {
              context.push('/wish_tree');
            },
          ),
          ListSectionItem(
            svgName: 'quick_options.svg',
            title: '快捷选项',
            path: '/home_page_management',
            onTap: () {
              context.push('/wish_tree');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.95;
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: 0, right: 0, top: 7, bottom: 7),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
        // color: const Color(0xFFF7F2FA),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: ListSection(
        titleStyle: const TextStyle(fontSize: 15, fontFamily: 'SW-Kai'),
        trailingIconColor: Colors.grey[400],
        items: [
          ListSectionItem(
            svgName: 'about_app.svg',
            title: '关于软件',
            path: '/about_app',
            onTap: () {
              context.push('/about_app');
            },
          ),
          ListSectionItem(
            svgName: 'author.svg',
            title: '关于作者',
            path: '/about_author',
            onTap: () {
              context.push('/about_author');
            },
          ),
          ListSectionItem(
            svgName: 'help.svg',
            title: '帮助与反馈',
            path: '/help_feedback',
            onTap: () {
              context.push('/help_feedback');
            },
          ),
        ],
      ),
    );
  }
}

// 定义列表项的数据模型
class ListSectionItem {
  final String svgName;
  final String title;
  final String path;
  final VoidCallback onTap;

  const ListSectionItem({
    required this.svgName,
    required this.title,
    required this.path,
    required this.onTap,
  });
}

// 封装的列表组件
class ListSection extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final Color? trailingIconColor;
  final List<ListSectionItem> items;

  const ListSection({
    super.key,
    this.margin,
    this.padding,
    this.borderRadius = 16,
    this.backgroundColor,
    this.titleStyle,
    this.trailingIconColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  'lib/assets/icons/svg/${item.svgName}',
                  width: 24,
                  height: 24,
                ),
                title: Text(item.title, style: titleStyle),
                trailing: Icon(Icons.chevron_right, color: trailingIconColor),
                onTap: item.onTap,
              ),
              if (index < items.length - 1) const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}
