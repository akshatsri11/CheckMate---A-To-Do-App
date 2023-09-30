class TaskModel {
  String title;
  String? description;
  String? status;

  TaskModel({
    required this.title,
    this.description,
    this.status,
  });
}
