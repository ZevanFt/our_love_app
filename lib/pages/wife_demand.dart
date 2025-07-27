import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// 导入路由配置文件
import '../routes/router.dart';

class WifeDemandPage extends StatefulWidget {
  const WifeDemandPage({Key? key}) : super(key: key);

  @override
  State<WifeDemandPage> createState() => _WifeDemandPageState();
}

class _WifeDemandPageState extends State<WifeDemandPage> {
  // 用于控制输入框内容
  final TextEditingController _demandController = TextEditingController();

  // 模拟提交需求的方法，实际可连接后端接口进行存储等操作
  void _submitDemand() {
    String demand = _demandController.text.trim();
    if (demand.isNotEmpty) {
      // 这里可以添加将需求发送到服务器或者本地存储的逻辑
      print("老婆的需求：$demand");
      // 提交后可清空输入框
      _demandController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("需求已收到，马上安排～")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("请输入你的需求呀～")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/suggest.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              '老婆需求小天地',
              style: TextStyle(fontFamily: 'TW-Kai', fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '亲爱的老婆～这里是专属你的需求小基地呀！不管是想给咱们的小软件加些超甜的新功能，比如给纪念日模块整个浪漫动画特效；还是觉得哪个功能用着不顺手，像“这顿吃什么”想多些美食推荐类型 ，都能在这儿说！ \n\n你要是幻想着软件有啥奇妙新玩法，比如给“许愿树”加个互动小惊喜，也赶紧告诉我～我随时准备好接收你的奇妙脑洞，把咱们的小世界变得更合你心意，毕竟你的开心就是我最想实现的需求呀❤️ ',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _demandController,
              maxLines: null, // 支持多行输入
              decoration: const InputDecoration(
                hintText: '请写下你的需求吧...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _submitDemand,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: const Text(
                  '提交需求',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
