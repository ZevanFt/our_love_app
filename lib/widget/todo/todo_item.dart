import 'package:flutter/material.dart';
import 'package:our_love/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?> onStatusChanged;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: todo.isDone, onChanged: onStatusChanged),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: todo.isDone ? Colors.grey : null,
        ),
      ),
      subtitle: Text('截止日期: ${todo.dueDate}'),
      onTap: () => onStatusChanged(!todo.isDone),
    );
  }
}
