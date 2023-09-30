import 'package:check_mate/models/task_model.dart';

class ProjectModel {
  String title;
  int totalTasks;
  int? completedTasks = 0;
  List<TaskModel> tasks = [];
  bool isSelected;
  ProjectModel({
    required this.title,
    this.completedTasks,
    required this.totalTasks,
    required this.tasks,
    required this.isSelected,
  });

  static List<ProjectModel> getProjects() {
    List<ProjectModel> projects = [];

    projects.add(
      ProjectModel(
          title: 'Holidays in Norway',
          completedTasks: 8,
          totalTasks: 10,
          tasks: [
            TaskModel(
              title: "Purchase travel insurance",
              description: "Bought it",
              status: "Completed",
            ),
          ],
          isSelected: true),
    );
    projects.add(ProjectModel(
        title: 'Daily\nTasks',
        completedTasks: 2,
        totalTasks: 4,
        isSelected: false,
        tasks: []));
    return projects;
  }
}
