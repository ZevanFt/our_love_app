import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CouponWalletPage extends StatefulWidget {
  const CouponWalletPage({super.key});

  @override
  State<CouponWalletPage> createState() => _CouponWalletPageState();
}

class _CouponWalletPageState extends State<CouponWalletPage> {
  // Mock data for coupons
  final List<Map<String, String>> _coupons = [
    {'name': '全场-5元优惠券', 'expiry': '2025-12-31'},
    {'name': '饮品第二杯半价', 'expiry': '2025-10-01'},
    {'name': '生日特别折扣券', 'expiry': '2025-08-28'},
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
        title: const Text('我的卡包'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined),
            onPressed: () {
              GoRouter.of(context).push('/coupon_history');
            },
            tooltip: '查看历史',
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _coupons.length,
          itemBuilder: (context, index) {
            final coupon = _coupons[index];
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
                    const Icon(
                      Icons.local_offer,
                      color: Colors.deepPurpleAccent,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '有效期至: ${coupon['expiry']!}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Implement use coupon logic
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurpleAccent,
                        side: const BorderSide(color: Colors.deepPurpleAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text('使用'),
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
