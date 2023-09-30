import 'package:check_mate/models/project_model.dart';
import 'package:check_mate/models/task_model.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  List<ProjectModel> projects = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ProjectModel? selectedProject;
  void _getProjects() {
    projects = ProjectModel.getProjects();
    selectedProject = projects[0];
  }

  void _showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('New Task Added!'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    _getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(size.width * .05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(size.width * .02),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 1, color: Colors.grey.shade300)),
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
              SizedBox(
                height: size.width * .05,
              ),
              Text(
                'New Task',
                style: textStyle.displaySmall!
                    .copyWith(fontWeight: FontWeight.w800),
              ),
              SizedBox(height: size.width * .06),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: size.width * .02),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                        vertical: size.width * .03),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * .1),
                        color: Colors.black,
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Text(
                      'Today',
                      style:
                          textStyle.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                        vertical: size.width * .03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * .1),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      'Tomorrow',
                      style: textStyle.bodyMedium,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(size.width * .02) -
                        EdgeInsets.only(left: size.width * .02),
                    padding: EdgeInsets.all(size.width * .03),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300)),
                    child: Icon(
                      Icons.alarm_add_outlined,
                      size: size.width * .05,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(size.width * .03),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300)),
                    child: Icon(
                      Icons.notification_add_outlined,
                      size: size.width * .05,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * .04),
                child: Text(
                  '\tPROJECTS',
                  style: textStyle.bodySmall!.copyWith(
                      letterSpacing: 1,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: size.width * .02),
                    padding: EdgeInsets.all(size.width * .03),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300)),
                    child: Icon(
                      Icons.add,
                      size: size.width * .05,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .06,
                    width: size.width * .75,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: size.width * .02,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .05,
                              vertical: size.width * .02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * .1),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            gradient: index % 2 == 0
                                ? RadialGradient(colors: [
                                    projects[index].isSelected
                                        ? Colors.deepPurple
                                        : Colors.transparent,
                                    projects[index].isSelected
                                        ? Colors.blue.shade900
                                        : Colors.transparent,
                                    projects[index].isSelected
                                        ? Colors.lightBlue
                                        : Colors.transparent,
                                  ], center: Alignment.center, radius: 1.8)
                                : RadialGradient(colors: [
                                    projects[index].isSelected
                                        ? Colors.deepPurple.shade900
                                        : Colors.transparent,
                                    projects[index].isSelected
                                        ? Colors.deepPurple.shade500
                                        : Colors.transparent,
                                    projects[index].isSelected
                                        ? Colors.yellow.shade800
                                        : Colors.transparent,
                                  ], center: Alignment.center, radius: 1.5),
                          ),
                          child: Text(
                            projects[index].title,
                            style: textStyle.bodyLarge!.copyWith(
                                color: projects[index].isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * .02),
                child: Text(
                  '\tTITLE',
                  style: textStyle.bodySmall!.copyWith(
                      letterSpacing: 1,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * .02),
                child: TextFormField(
                  controller: titleController,
                  style: textStyle.bodyLarge!
                      .copyWith(letterSpacing: 1, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * .1),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * .1),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(size.width * .05),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * .02),
                child: TextFormField(
                  controller: descriptionController,
                  style: textStyle.bodyLarge!.copyWith(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    hintStyle: textStyle.bodyLarge!.copyWith(
                        color: Colors.grey.shade600, letterSpacing: 1),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * .1),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * .1),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(size.width * .05),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .15,
              ),
              InkWell(
                onTap: () {
                  TaskModel task = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text);
                  selectedProject!.tasks.add(task);
                  _showSnackBar(context);
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: size.width * .02),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .05, vertical: size.width * .03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * .1),
                      color: Colors.black,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Text(
                    'Create',
                    style: textStyle.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
