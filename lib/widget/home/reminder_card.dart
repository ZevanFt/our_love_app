import 'package:flutter/material.dart';

class DrinkWaterReminderCard extends StatelessWidget {
  const DrinkWaterReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            _buildWaterProgress(),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '已完成 6 / 10 杯',
                    style: TextStyle(
                      fontFamily: 'SW-Kai',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '继续加油哦！',
                    style: TextStyle(
                      fontFamily: 'SW-Kai',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('记录一杯'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'SW-Kai',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterProgress() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 0.6,
            strokeWidth: 10,
            backgroundColor: Colors.blue.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Center(
            child: Icon(
              Icons.water_drop_rounded,
              color: Colors.blue.withOpacity(0.8),
              size: 45,
            ),
          ),
        ],
      ),
    );
  }
}
