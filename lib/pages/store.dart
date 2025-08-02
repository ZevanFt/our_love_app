import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:our_love/pages/product_edit.dart';

// 创建 StatefulWidget 类
class PointsStore extends StatefulWidget {
  const PointsStore({super.key});

  @override
  State<PointsStore> createState() => _PointsStoreState();
}

// 创建对应的 State 类
class _PointsStoreState extends State<PointsStore> {
  // 模拟商品数据
  final List<Map<String, dynamic>> _products = [
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '和好券',
      'points': '1',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '和好券',
      'points': '1',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '朋友听话券（一天）',
      'points': '52',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '蜜雪冰城自选一杯券',
      'points': '50',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '女朋友听话券（一天）',
      'points': '50',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '小礼物券',
      'points': '50',
    },
    {
      'image': 'lib/assets/images/he-hao.jpg', // 替换为实际图片路径
      'name': '益禾堂自选一杯券',
      'points': '50',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double crossAxisSpacing = 15;
    const double padding = 16;
    final double cardWidth = (screenWidth - crossAxisSpacing - 2 * padding) / 2;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 显示天气图标
            SvgPicture.asset(
              'lib/assets/icons/svg/point_store.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            // 显示页面标题
            const Text(
              '积分商城',
              style: TextStyle(fontFamily: 'SW-Kai', fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text(
              '添加商品',
              style: TextStyle(fontSize: 16, fontFamily: 'SW-Kai'),
            ),
            onPressed: () {
              context.go('/product_edit');
            },
            // 点击添加商品按钮，执行相应逻辑
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 积分
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFdf89b5), Color(0xFFbfd9fe)],
                  ),
                ),
                child: Column(
                  children: [
                    // 使用 Row 让按钮靠右
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.push('/coupon_wallet');
                          },
                          // 设置按钮样式以减小行高
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero, // 取消最小尺寸限制
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 18,
                            ), // 调整内边距
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap, // 缩小点击区域
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '进入卡包',
                                style: TextStyle(
                                  color: Color(0xFF7873f5),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'TW-Kai',
                                ),
                              ),
                              const SizedBox(width: 4), // 图标和文字间添加间距
                              const Icon(
                                Icons.keyboard_double_arrow_right_outlined,
                                color: Color(0xFF7873f5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '30',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 8), // 文字和图标之间添加间距
                        SvgPicture.asset(
                          'lib/assets/icons/svg/point.svg',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '当前积分',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // 使用 ListView 嵌套 Row 实现网格布局
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (_products.length / 2).ceil(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final startIndex = index * 2;
                  final endIndex = startIndex + 2;
                  final items = _products.sublist(
                    startIndex,
                    endIndex > _products.length ? _products.length : endIndex,
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items.map((product) {
                      return SizedBox(
                        width: cardWidth,
                        child: _buildMallItem(
                          product['image'],
                          product['name'],
                          product['points'],
                        ),
                      );
                    }).toList(),
                  );
                },
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
          ),
        ),
      ),
    );
  }

  Widget _buildMallItem(String imagePath, String name, String points) {
    Widget imageWidget;
    if (imagePath.startsWith('lib/assets/')) {
      imageWidget = Image.asset(imagePath, height: 120, fit: BoxFit.cover);
    } else {
      imageWidget = Image.file(File(imagePath), height: 120, fit: BoxFit.cover);
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 展示商品图片，使用 ClipRRect 裁剪图片为圆角
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: imageWidget,
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF212529),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 使用 Row 组件将积分数值和图标水平排列
              Row(
                children: [
                  Text(
                    points, // 只显示积分数值
                    style: const TextStyle(
                      color: Color(0xFF7873f5),
                      // color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4), // 数值和图标之间添加间距
                  SvgPicture.asset(
                    'lib/assets/icons/svg/point.svg',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFB6CEE8), Color(0xFFF578DC)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    // 兑换逻辑，点击按钮时执行
                    debugPrint('兑换');
                    // 弹窗是否确认兑换
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // 设置弹窗背景色
                          backgroundColor: Colors.white,
                          // 设置弹窗圆角
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // 设置弹窗内边距
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 24,
                          ),
                          // 设置弹窗标题
                          title: const Text(
                            '兑换确认',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'TW-Kai',
                            ),
                          ),
                          // 设置弹窗内容
                          content: const Text(
                            '是否确认兑换该券？',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          // 设置弹窗操作按钮
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // 设置按钮样式
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey,
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text(
                                '取消',
                                style: TextStyle(fontFamily: 'TW-Kai'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // 设置按钮样式
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.pinkAccent,
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text(
                                '确认',
                                style: TextStyle(fontFamily: 'TW-Kai'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Text(
                      '兑换',
                      style: TextStyle(fontSize: 12, fontFamily: 'TW-Kai'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
