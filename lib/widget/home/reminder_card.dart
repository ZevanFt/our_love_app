import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          _buildSectionHeader(context, title: '日程提醒'),
          const SizedBox(height: 8),
          _buildReminderItem(
            context,
            title: '上班',
            subtitle: '即将成为牛马',
            date: '2025.7.25',
          ),
          const Divider(),
          _buildReminderItem(
            context,
            title: '研究生入学',
            subtitle: '项目讨论',
            date: '2025.7.25',
          ),
          const SizedBox(height: 16),
          _buildSectionHeader(context, title: '喝水提醒'),
          const SizedBox(height: 8),
          _buildWaterReminder(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        TextButton(onPressed: () {}, child: const Text('切换到伴侣')),
      ],
    );
  }

  Widget _buildReminderItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String date,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(date),
      onTap: () {},
    );
  }

  Widget _buildWaterReminder(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('今天你喝水了没?'),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('记录'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // A simple progress bar
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
