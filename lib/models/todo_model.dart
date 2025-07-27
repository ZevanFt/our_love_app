class TodoModel {
  final String id;
  final String title;
  final String dueDate;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isDone = false,
  });
}
