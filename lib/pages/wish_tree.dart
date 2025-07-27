// 导入Material UI 组件库
// Material 是一种标准的移动端和web端的视觉设计语言
// Flutter 默认提供了一套丰富的 Material 风格的UI组件
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WishTree extends StatefulWidget {
  const WishTree({Key? key}) : super(key: key);

  @override
  State<WishTree> createState() => _WishTreeState();
}

class _WishTreeState extends State<WishTree> {
  // 初始化状态
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/wish_tree.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('许愿树', style: TextStyle(fontFamily: 'TW-Kai')),
          ],
        ),
        centerTitle: true, // 让title整体居中
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // print('测试是否点击---返回上一页');
            // 返回上一页
            context.pop();
          },
        ),
      ),
      // 添加 Container 并设置渐变背景
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink[200]!, Colors.blue[200]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/wishTree.png',
                width: MediaQuery.of(context).size.width * 0.75,
                // height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
