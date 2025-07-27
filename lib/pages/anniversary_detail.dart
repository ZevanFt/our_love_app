import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:our_love/models/anniversary_type.dart';
// 导入渐变配置文件
import 'package:our_love/utils/gradients.dart';

class AnniversaryDetailPage extends StatelessWidget {
  final String title;
  final DateTime date;
  final int daysDiff;
  final String description;
  final bool isRecurring;
  final AnniversaryType type;
  final String icon;
  final Color color;

  const AnniversaryDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.daysDiff,
    required this.description,
    required this.isRecurring,
    required this.type,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    String daysText = daysDiff >= 0 ? '还有 $daysDiff 天' : '已经 ${-daysDiff} 天';
    String dateLabel = daysDiff >= 0 ? '目标日' : '起始日';
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    List<dynamic> svgDigits = []; // 改为 dynamic 类型，因为可能存储字符串或 Widget

    // 处理天数文本，将每个数字转换为对应的 SVG 图标路径
    String cleanDaysText = daysText
        .replaceAll('还有 ', '')
        .replaceAll('已经 ', '')
        .replaceAll(' 天', '');
    for (var char in cleanDaysText.split('')) {
      if (char.isNotEmpty && int.tryParse(char) != null) {
        svgDigits.add('lib/assets/icons/svg/${char}.svg'); // 直接存储路径
      } else {
        svgDigits.add(Text(char, style: const TextStyle(fontSize: 40)));
      }
    }
    // svgDigits.add(const Text('天', style: TextStyle(fontSize: 40)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('纪念日详情', style: TextStyle(fontFamily: 'TW-Kai')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print('编辑纪念日');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // 设置渐变背景
          gradient: wishTreeGradient,
        ),
        child: Stack(
          children: [
            // 使用新创建的卡片组件
            Center(
              child: AnniversaryDetailCard(
                // 确保所有参数都使用命名参数形式传递
                title: title,
                daysText: daysText,
                dateLabel: dateLabel,
                formattedDate: formattedDate,
                svgDigits: svgDigits,
                daysDiff: daysDiff,
                containerColor: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 新创建的卡片组件
class AnniversaryDetailCard extends StatelessWidget {
  final String title;
  final String daysText;
  final String dateLabel;
  final String formattedDate;
  final List<dynamic> svgDigits; // 改为 dynamic 类型
  final int daysDiff;
  final Color containerColor; // 新增属性，用于接收传入的颜色

  const AnniversaryDetailCard({
    super.key,
    required this.title,
    required this.daysText,
    required this.dateLabel,
    required this.formattedDate,
    required this.svgDigits,
    required this.daysDiff,
    required this.containerColor, // 新增参数
  });

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    // 处理 svgDigits，设置大小和颜色
    List<Widget> processedSvgDigits = svgDigits.map((item) {
      if (item is String) {
        return SvgPicture.asset(
          item,
          width: 70, // 设置 SVG 宽度
          height: 70, // 设置 SVG 高度
          colorFilter: const ColorFilter.mode(
            Colors.black, // 设置 SVG 颜色
            // 使用 BlendMode.srcIn 可以让颜色只影响 SVG 的填充部分
            BlendMode.srcIn,
          ), // 设置 SVG 颜色
        );
      }
      return item as Widget;
    }).toList();

    return SizedBox(
      width: screenWidth * 0.85, // 设置卡片宽度为屏幕宽度的 80%
      height: screenWidth * 0.75, // 设置卡片高度为屏幕
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // 与 Container 圆角保持一致
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 显示 title
              Container(
                width: double.infinity, // 设置宽度为父级的 100%
                height: 50, // 设置高度
                color: containerColor, // 使用传入的颜色设置背景
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      daysDiff >= 0 ? '还有 ' : '已经 ',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // 显示天数
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...processedSvgDigits], // 使用处理后的 svgDigits
              ),
              const SizedBox(height: 20),
              // 显示起始日/目标日
              Container(
                width: double.infinity, // 设置宽度为父级的 100%
                height: 50, // 设置高度
                color: Colors.grey[200], // 设置背景颜色
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$dateLabel: $formattedDate',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
