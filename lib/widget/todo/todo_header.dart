import 'package:flutter/material.dart';

class TodoHeader extends StatelessWidget {
  final int remainingTasks;

  const TodoHeader({super.key, required this.remainingTasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('今日任务', style: Theme.of(context).textTheme.headlineMedium),
              Text(
                '还剩 $remainingTasks 项任务',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          // You can add a button or other actions here if needed
          // e.g., a filter button
        ],
      ),
    );
  }
}
