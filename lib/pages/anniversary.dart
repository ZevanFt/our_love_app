// 导入所需的包
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:our_love/pages/anniversary_detail.dart';
// 导入新创建的枚举文件
import 'package:our_love/models/anniversary_type.dart';
// 导入路由配置文件
import '../routes/router.dart';

// 定义图标选项
final List<String> iconOptions = [
  'lib/assets/icons/svg/default_icon.svg',
  // 可添加更多图标路径
];

// 定义颜色选项
final List<Color> colorOptions = [
  Colors.grey,
  // 可添加更多颜色
  Colors.blueAccent,
  Colors.orangeAccent,
];

class AnniversaryPage extends StatefulWidget {
  const AnniversaryPage({super.key});

  @override
  State<AnniversaryPage> createState() => _AnniversaryPageState();
}

class _AnniversaryPageState extends State<AnniversaryPage> {
  // 初始化 memorialDays 列表，确保每个元素包含所有必要字段
  List<Map<String, dynamic>> memorialDays = [
    {
      'title': '和宝宝在一起',
      'date': DateTime(2024, 11, 22),
      'isPinned': true,
      'description': '',
      'isRecurring': false,
      'type': AnniversaryType.life,
      'icon': iconOptions[0],
      'color': colorOptions[2],
    },
    {
      'title': '一周年纪念日',
      'date': DateTime(2025, 11, 22),
      'isPinned': false,
      'description': '',
      'isRecurring': false,
      'type': AnniversaryType.life,
      'icon': iconOptions[0],
      'color': colorOptions[1],
    },
    // 其他元素...
  ];

  void _showAddAnniversaryDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    DateTime? selectedDate;
    bool isRecurring = false;
    AnniversaryType selectedType = AnniversaryType.life;
    String selectedIcon = iconOptions[0];
    Color selectedColor = colorOptions[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '添加纪念日',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: '纪念日标题',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('选择日期'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 使用 go_router 的 pop 方法关闭对话框
                        GoRouter.of(context).pop();
                      },
                      child: const Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();
                        if (title.isNotEmpty && selectedDate != null) {
                          setState(() {
                            memorialDays.add({
                              'title': title,
                              'date': selectedDate!,
                              'isPinned': false,
                              'description': description,
                              'isRecurring': isRecurring,
                              'type': selectedType,
                              'icon': selectedIcon,
                              'color': selectedColor,
                            });
                          });
                          // 使用 go_router 的 pop 方法关闭对话框
                          GoRouter.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('确定'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _calculateDaysDifference(DateTime targetDate) {
    DateTime now = DateTime.now();
    Duration difference = targetDate.difference(now);
    return difference.inDays;
  }

  // 处理天数为 SVG 图标列表
  List<Widget> _daysToSvgIcons(String daysText) {
    List<Widget> svgDigits = [];
    String cleanDaysText = daysText.replaceAll(' 天', '');
    for (var char in cleanDaysText.split('')) {
      // 检查字符是否为数字
      // 如果是数字，则转换为对应的 SVG 图标
      if (char.isNotEmpty && int.tryParse(char) != null) {
        svgDigits.add(
          SvgPicture.asset(
            'lib/assets/icons/svg/${char}.svg',
            width: 35, // 设置 SVG 宽度
            height: 35, // 设置 SVG 高度
            colorFilter: const ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
        );
        // 如果不是数字，则直接添加文本
      } else {
        svgDigits.add(
          Text(
            char,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }
    // 返回处理后的 SVG 图标列表
    return svgDigits;
  }

  @override
  Widget build(BuildContext context) {
    final pinnedItems = memorialDays.where((item) => item['isPinned']).toList();
    final nonPinnedItems = memorialDays
        .where((item) => !item['isPinned'])
        .toList();
    final sortedItems = [...pinnedItems, ...nonPinnedItems];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/svg/anniversary.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              '纪念日',
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
        actions: [
          IconButton(
            onPressed: _showAddAnniversaryDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: sortedItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = sortedItems[index];
            DateTime targetDate = item['date'];
            int daysDiff = _calculateDaysDifference(targetDate);
            String daysText = daysDiff >= 0 ? '$daysDiff 天' : '${-daysDiff} 天';
            String daysTitle = daysDiff >= 0
                ? '${item['title']}还有'
                : '${item['title']}已经';
            final isPinned = item['isPinned'] ?? false;
            // 如果没有指定颜色，则使用默认颜色
            final color = item['color'] as Color? ?? Colors.grey;
            // 处理可能为 null 的 String 类型字段
            final title = item['title'] as String? ?? '未命名纪念日';
            final description = item['description'] as String? ?? '暂无描述';
            final icon =
                item['icon'] as String? ??
                'lib/assets/icons/svg/default_icon.svg';

            // 格式化日期
            String formattedDate = DateFormat('yyyy-MM-dd').format(targetDate);
            // 判断显示起始日还是目标日
            String dateLabel = daysDiff >= 0 ? '目标日' : '起始日';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnniversaryDetailPage(
                      title: title,
                      date: targetDate,
                      daysDiff: daysDiff,
                      description: description,
                      isRecurring: item['isRecurring'] as bool? ?? false,
                      type:
                          item['type'] as AnniversaryType? ??
                          AnniversaryType.life,
                      icon: icon,
                      color: color,
                    ),
                  ),
                );
              },
              child: Center(
                child: UnconstrainedBox(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 第一行：左侧图标和名称，右侧天数
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isPinned
                                        ? Icons.push_pin
                                        : Icons.favorite_border,
                                    color: isPinned ? Colors.blue : null,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    daysTitle,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isPinned
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              // 右侧天数
                              isPinned
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ..._daysToSvgIcons(daysText),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Text(
                                            'days',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isPinned ? 16 : 12,
                                        vertical: isPinned ? 6 : 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        daysText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isPinned ? 18 : 14,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // 使用 if 条件判断，仅在置顶时显示该行组件
                          // if (isPinned)
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                '$dateLabel: ',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
