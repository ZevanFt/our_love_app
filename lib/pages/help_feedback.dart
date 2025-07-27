import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HelpFeedbackPage extends StatefulWidget {
  const HelpFeedbackPage({Key? key}) : super(key: key);

  @override
  State<HelpFeedbackPage> createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    String feedback = _feedbackController.text.trim();
    if (feedback.isNotEmpty) {
      // 这里可添加提交反馈到服务器等逻辑，比如调用接口
      debugPrint('提交的反馈：$feedback');
      _feedbackController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('反馈已提交，感谢你的支持～'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入你的反馈内容呀～'),
          duration: Duration(seconds: 2),
        ),
      );
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
              'lib/assets/icons/svg/help.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('帮助与反馈', style: TextStyle(fontFamily: 'TW-Kai')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('遇到问题或有好的建议？在这里告诉我们吧～', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '请详细描述你的问题或建议...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _submitFeedback,
                child: const Text('提交反馈'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
