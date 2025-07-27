import 'package:flutter/material.dart';
import 'package:our_love/models/todo_model.dart';
import 'package:our_love/widget/todo/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(String, bool) onTodoStatusChanged;

  const TodoList({
    super.key,
    required this.todos,
    required this.onTodoStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onStatusChanged: (isDone) {
            if (isDone != null) {
              onTodoStatusChanged(todo.id, isDone);
            }
          },
        );
      },
    );
  }
}
