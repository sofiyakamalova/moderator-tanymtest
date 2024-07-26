import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/add_groups_or_students/add_student_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/student_details_page.dart';

class StudentsListPage extends StatefulWidget {
  final GroupModel group;
  const StudentsListPage({super.key, required this.group});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    await groupProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: widget.group.group_name,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white_color,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.background_color,
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary_color,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else {
              return Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  return StreamBuilder<List<StudentModel>>(
                    stream: groupProvider.getStudents(widget.group.group_id),
                    builder:
                        (context, AsyncSnapshot<List<StudentModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary_color,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Ошибка: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Нет данных'));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'Студентов ${snapshot.data!.length}',
                              color: AppColors.dark_grey_color,
                              size: 20,
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white_color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  padding: const EdgeInsets.all(10.0),
                                  separatorBuilder: (_, __) {
                                    return const Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Divider(),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    StudentModel student =
                                        snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Перейти на страницу деталей студента, если необходимо
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StudentDetailsPage(
                                              student_uid: student.uid,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 27,
                                            backgroundImage: NetworkImage(
                                              student.image == ''
                                                  ? 'https://samarkand.itcamp.uz/assest/img/reviews/no-pic-ava.jpg'
                                                  : student.image,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          CommonText(text: student.name),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary_color,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddStudentPage(groupId: widget.group.group_id),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white_color,
          ),
        ),
      ),
    );
  }
}
