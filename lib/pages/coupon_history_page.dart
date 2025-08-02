import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CouponHistoryPage extends StatelessWidget {
  CouponHistoryPage({super.key});

  // Mock data for used coupons
  final List<Map<String, String>> _usedCoupons = [
    {'name': '新用户专享-10元券', 'date': '2025-07-20'},
    {'name': '夏季特饮买一送一', 'date': '2025-07-15'},
    {'name': '满50减5元', 'date': '2025-06-01'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => GoRouter.of(context).pop(),
          tooltip: '返回',
        ),
        title: const Text('历史卡券'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _usedCoupons.length,
          itemBuilder: (context, index) {
            final coupon = _usedCoupons[index];
            return Card(
              elevation: 4.0,
              shadowColor: Colors.black26,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey[400],
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon['name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '使用于: ${coupon['date']!}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
