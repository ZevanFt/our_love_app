import 'package:flutter/material.dart';
import 'package:our_love/models/todo_model.dart';
import 'package:our_love/widget/todo/todo_header.dart';
import 'package:our_love/widget/todo/todo_list.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // Using mock data for now
  final List<TodoModel> _todos = [
    TodoModel(id: '1', title: '完成Flutter项目', dueDate: '2025-07-27'),
    TodoModel(id: '2', title: '学习新的设计模式', dueDate: '2025-07-28', isDone: true),
    TodoModel(id: '3', title: '准备周会报告', dueDate: '2025-07-29'),
    TodoModel(id: '4', title: '阅读《代码整洁之道》', dueDate: '2025-07-30'),
  ];

  void _handleTodoStatusChange(String id, bool isDone) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.isDone = isDone;
    });
  }

  int get _remainingTasks => _todos.where((t) => !t.isDone).length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoHeader(remainingTasks: _remainingTasks),
        Expanded(
          child: TodoList(
            todos: _todos,
            onTodoStatusChanged: _handleTodoStatusChange,
          ),
        ),
      ],
    );
  }
}
