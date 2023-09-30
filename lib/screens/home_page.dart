import 'package:check_mate/models/project_model.dart';
import 'package:check_mate/screens/cretae_new_task.dart';
import 'package:check_mate/screens/daily_tasks.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProjectModel> projects = [];

  void _getProjects() {
    projects = ProjectModel.getProjects();
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Text(
                'Hello, Micheal',
                style:
                    textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: RichText(
                    text: TextSpan(style: textStyle.displaySmall, children: [
                      TextSpan(
                        text: 'Your Projects ',
                        style: textStyle.displaySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '(${projects.length})')
                    ]),
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * .15),
                    child: CircleAvatar(
                      radius: size.width * .1,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * .07,
            ),
            ProjectList(size: size, projects: projects, textStyle: textStyle),
          ],
        ),
      ),
    );
  }
}

class ProjectList extends StatelessWidget {
  const ProjectList({
    super.key,
    required this.size,
    required this.projects,
    required this.textStyle,
  });

  final Size size;
  final List<ProjectModel> projects;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .8,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: size.width * .03),
          shrinkWrap: true,
          itemCount: projects.length,
          separatorBuilder: (context, index) => SizedBox(
                height: size.width * .02,
              ),
          itemBuilder: (context, index) {
            return Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * .1),
                gradient: index % 2 == 0
                    ? RadialGradient(
                        colors: [
                          Colors.deepPurple,
                          Colors.blue.shade900,
                          Colors.lightBlue,
                        ],
                        center: Alignment.center,
                        radius: .7,
                      )
                    : RadialGradient(
                        colors: [
                          Colors.deepPurple.shade900,
                          Colors.deepPurple.shade500,
                          Colors.yellow.shade800,
                        ],
                        center: Alignment.center,
                        radius: .7,
                      ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .03) +
                              EdgeInsets.only(top: size.height * .05),
                      child: Text(
                        projects[index].title,
                        style: textStyle.displaySmall!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .03),
                      child: Row(
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
                                '${projects[index].completedTasks}/${projects[index].tasks.length}',
                                style: textStyle.headlineMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetails(
                                    projectDetails: projects[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(size.width * .05),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                  border: Border.all(color: Colors.white)),
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              projects[index].isSelected = true;
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
                                  color: Colors.white.withOpacity(0.7),
                                  border: Border.all(color: Colors.white)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            );
          }),
    );
  }
}
