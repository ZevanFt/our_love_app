import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:chinese_lunar_calendar/chinese_lunar_calendar.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  // 获取当前新历日期
  String getCurrentSolarDate() {
    final now = DateTime.now();
    // print('$now 当前时间');
    return DateFormat('yyyy-MM-dd').format(now);
  }

  // 获取当前农历日期
  String getCurrentLunarDate() {
    try {
      // 获取当前UTC时间
      final currentUtcTime = DateTime.now().toUtc();
      // 从当前UTC时间创建农历日历对象
      final lunarCalendar = LunarCalendar.from(utcDateTime: currentUtcTime);
      // 打印完整农历汉字表示（如：二〇二三年腊月廿七）
      // print('阴历汉字: ${lunarCalendar.lunarDate.fullCNString}');
      // 通过 lunarDate 获取农历日期对象
      final lunarDate = lunarCalendar.lunarDate;
      // 从 lunarDate 对象获取农历月份的字符串表示,获取农历月份和日期（如：六月初十）
      // 调用 getValue 方法获取农历月份
      String lunarMonth = lunarDate.lunarMonth.lunarMonthCN
          .getValue(); // 农历月（如“六月”）
      // String lunarMonth = lunarDate.lunarMonth.lunarMonthCN.toString();
      // print('$lunarMonth,农历月份');
      String lunarDay = lunarDate.lunarDayCN.toString();
      // 调用 getValue 方法获取农历日期:错误🙅‍♂️
      // String lunarDay = lunarDate.lunarDayCN.getValue();
      // print('$lunarDay,农历日期');
      // return '$lunarMonth$lunarDay'; // 返回“六月初十”
      // return '${lunarCalendar.lunarDate.lunarMonth.cnName}月${lunarDate.chineseDay}';
      return '农历$lunarMonth$lunarDay';
    } catch (e) {
      // 发生异常时返回默认值
      // print('获取农历日期出错: $e');
      return '获取农历日期出错:未知';
    }
  }

  // 计算从特定日期到现在的天数
  int calculateDaysTogether() {
    final startDate = DateTime(2024, 11, 22);
    final now = DateTime.now();
    return now.difference(startDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前路由
    final location = GoRouterState.of(context).uri.toString();
    // 主页、完成页、商店页、关于我页的索引，确保包含 /home 路径
    final tabs = ['/more_tool', '/todo', '/home', '/store', '/about_me'];
    int currentIndex = tabs.indexWhere((e) => e == location);
    if (currentIndex == -1) currentIndex = 2; // 默认选中主页

    // 关于我页不显示AppBar
    final bool showAppBar = location != '/store' && location != '/about_me';
    // final bool showAppBar = true; // 强制显示AppBar

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              // 试一试：尝试将此处的颜色更改为特定颜色（比如 Colors.amber）
              // 并触发热重载，查看应用栏颜色变化，而其他颜色保持不变。
              // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              backgroundColor: Colors.white,
              elevation: 0,
              // 这里我们使用由 App.build 方法创建的 MyHomePage 对象的值
              // 并将其用于设置应用栏标题
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 左侧：日期和农历
                  Column(
                    children: [
                      // 第一行日期
                      Text(
                        getCurrentSolarDate(), // 第一行日期
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TW-Kai',
                        ),
                      ),
                      // 第二行农历
                      Text(
                        getCurrentLunarDate(), // 第二行农历
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: 'TW-Kai',
                        ),
                      ),
                    ],
                  ),

                  // 中间：在一起天数
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 在一起
                        Text(
                          '在一起',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'TW-Kai',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.favorite, // 使用爱心图标
                          size: 16,
                          color: Colors.pink, // 红色爱心
                        ),
                        // 天数！！！
                        Text(
                          // 将 int 类型转换为 String 类型
                          calculateDaysTogether().toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                            fontFamily: 'TW-Kai',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '天',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'TW-Kai',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,

      body: child,

      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // 第一个图标按钮
            Container(
              decoration: BoxDecoration(
                // 选中时设置背景颜色
                color: currentIndex == 0
                    ? Colors.pink[200]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.local_activity_outlined),
                color: currentIndex == 0 ? Colors.white : Colors.grey,
                onPressed: () {
                  if (currentIndex != 0) context.go(tabs[0]);
                },
              ),
            ),
            // 第二个图标按钮
            Container(
              decoration: BoxDecoration(
                // 选中时设置背景颜色
                color: currentIndex == 1
                    ? Colors.pink[200]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.done_all),
                color: currentIndex == 1 ? Colors.white : Colors.grey,
                onPressed: () {
                  if (currentIndex != 1) context.go(tabs[1]);
                },
              ),
            ),
            const SizedBox(width: 50), // 悬浮按钮留出空间
            // 第三个图标按钮
            Container(
              decoration: BoxDecoration(
                // 选中时设置背景颜色
                color: currentIndex == 3
                    ? Colors.pink[200]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.storefront_outlined),
                color: currentIndex == 3 ? Colors.white : Colors.grey,
                onPressed: () {
                  if (currentIndex != 3) context.go(tabs[3]);
                },
              ),
            ),
            // 第四个图标按钮
            Container(
              decoration: BoxDecoration(
                // 选中时设置背景颜色
                color: currentIndex == 4
                    ? Colors.pink[200]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.person_outline),
                color: currentIndex == 4 ? Colors.white : Colors.grey,
                onPressed: () {
                  if (currentIndex != 4) context.go(tabs[4]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: currentIndex == 2 ? Colors.pink[200] : Colors.grey,
        foregroundColor: Colors.white,
        onPressed: () {
          if (currentIndex != 2) context.go(tabs[2]);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.favorite_border_outlined),
      ),
    );
  }
}
