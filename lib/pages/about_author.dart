import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AboutAuthorPage extends StatelessWidget {
  // 直接将 key 作为 super 构造函数的参数
  const AboutAuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/author.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('关于作者', style: TextStyle(fontFamily: 'TW-Kai')),
          ],
        ),
        centerTitle: true, // 让title整体居中
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 返回上一页
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '作者：且试新茶趁年华',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '某大厂硬件测试工程师，主业为修空调（不是），副业为业余程序员，热爱编程与设计，希望通过打造这款情侣应用，传递爱意与温暖，助力每一对情侣留住珍贵的恋爱回忆。',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              '联系我们',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '如果你对应用有任何想法、建议或遇到问题，可通过以下方式联系：',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '邮箱：example@xxx.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
