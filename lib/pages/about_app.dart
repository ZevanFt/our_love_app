import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/about_app.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('关于软件', style: TextStyle(fontFamily: 'TW-Kai')),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '情侣专属应用',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '这是一款为情侣打造的专属应用，旨在记录恋爱日常、增进彼此互动，提供丰富实用的情侣专属功能，陪伴你们走过每一段甜蜜时光。',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              '版本信息',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('当前版本：1.0.0', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              '感谢使用',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '希望这款应用能成为你们恋爱旅程中的美好陪伴，若有任何建议或问题，欢迎通过“帮助与反馈”告知我们～',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20), // 按钮与上方文本添加间距
            // 添加检查更新按钮
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 这里添加检查更新的逻辑
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('正在检查更新...')));
                },
                child: const Text(
                  '检查更新',
                  style: TextStyle(fontFamily: 'TW-Kai'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
