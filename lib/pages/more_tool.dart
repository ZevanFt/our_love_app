import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// 导入路由配置
import '../routes/router.dart';
// 导入页面

class MoreTool extends StatelessWidget {
  const MoreTool({super.key});

  // 将列表声明为常量
  static const List<Map<String, String>> tools = [
    {'title': '宝宝辛苦日', 'svgName': 'menstrual_period.svg', 'path': '/wish_tree'},
    {'title': '爱爱记录', 'svgName': 'love_record.svg', 'path': '/wish_tree'},
    {'title': '纪念日', 'svgName': 'anniversary.svg', 'path': '/anniversary'},
    {'title': '睡眠情况', 'svgName': 'sleepping.svg', 'path': '/wish_tree'},
    {'title': '许愿树', 'svgName': 'wish_tree.svg', 'path': '/wish_tree'},
    {'title': '礼物柜', 'svgName': 'gift.svg', 'path': '/wish_tree'},
    {'title': '天气预报', 'svgName': 'weather.svg', 'path': '/wish_tree'},
    {'title': '位置共享', 'svgName': 'location.svg', 'path': '/wish_tree'},
    {'title': '心情日记', 'svgName': 'mood.svg', 'path': '/wish_tree'},
    {'title': '保质期管理', 'svgName': 'term.svg', 'path': '/wish_tree'},
    {'title': '今天水了没', 'svgName': 'drink_water.svg', 'path': '/wish_tree'},
    {'title': '这顿吃什么', 'svgName': 'recipe.svg', 'path': '/wish_tree'},
    {'title': '今日屎今日毕', 'svgName': 'shit.svg', 'path': '/wish_tree'},
    {'title': '记账本', 'svgName': 'cash_book.svg', 'path': '/wish_tree'},
    {'title': '老婆提需求', 'svgName': 'suggest.svg', 'path': '/wife_demand'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('images/tool_swiper.png', fit: BoxFit.cover),
            ),
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95, // 与上方图片一致
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: tools.length,
              itemBuilder: (BuildContext context, int index) {
                final tool = tools[index];
                return GestureDetector(
                  onTap: () => {
                    // 跳转到对应页面
                    // print('点击-' + tool['title']! + ',跳转-' + tool['svgName']!),
                    context.push(tool['path']!),
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icons/svg/${tool['svgName']}',
                          width: 32,
                          height: 32,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            tool['title']!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'SW-Kai',
                              color: Colors.black87,
                              letterSpacing: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

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
    );
  }
}
