import 'package:check_mate/models/project_model.dart';
import 'package:check_mate/screens/cretae_new_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class ProjectDetails extends StatefulWidget {
  ProjectDetails({required this.projectDetails, super.key});
  ProjectModel projectDetails;
  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskBoard(
              size: size,
              textStyle: textStyle,
              projectDetails: widget.projectDetails,
            ),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widget.projectDetails.tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: timeDilation != 1.0,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      timeDilation = value! ? 5.0 : 1.0;
                    });
                  },
                  title: Text(widget.projectDetails.title),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.width * .04, horizontal: size.width * .05),
              child: Text(
                'COMPLETED (2)',
                style: textStyle.bodySmall!.copyWith(
                    letterSpacing: 1,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w300),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: timeDilation != 1.0,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      timeDilation = value! ? 5.0 : 1.0;
                    });
                  },
                  title: const Text('Create a presentation in Keynote'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskBoard extends StatelessWidget {
  const TaskBoard({
    super.key,
    required this.size,
    required this.projectDetails,
    required this.textStyle,
  });

  final Size size;
  final ProjectModel projectDetails;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * .1),
            gradient: RadialGradient(colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade500,
              Colors.yellow.shade800,
            ], center: Alignment.center, radius: .7),
          ),
          height: size.height * .5,
        ),
        Padding(
          padding: EdgeInsets.all(
            size.width * .05,
          ),
          child: SizedBox(
            height: size.height * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(size.width * .04),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7)),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: size.width * .04,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(size.width * .04),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.7)),
                      child: Icon(
                        Icons.more_horiz,
                        size: size.width * .04,
                      ),
                    ),
                  ],
                ),
                Text(
                  projectDetails.title,
                  style: textStyle.displaySmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 17,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${projectDetails.completedTasks}/${projectDetails.tasks.length}',
                          style: textStyle.headlineMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'tasks',
                          style: textStyle.bodyLarge!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewTask(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(size.width * .05),
                    alignment: Alignment.center,
                    height: size.height * .1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple[100],
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: size.width * .1,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
