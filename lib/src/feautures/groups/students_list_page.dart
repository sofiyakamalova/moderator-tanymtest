import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/add_groups_or_students/add_student_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/student_details_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/provider/auth_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/psychologist_model.dart';

class StudentsListPage extends StatefulWidget {
  final GroupModel group;
  const StudentsListPage({super.key, required this.group});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  final AuthProvider _authProvider = AuthProvider();
  late Stream<List<StudentModel>> _studentStream;

  @override
  void initState() {
    // TODO: implement initState
    _studentStream = Stream.empty();
    _initializeStreams();
    super.initState();
  }

  void _initializeStreams() async {
    final PsychologistModel? user = await _authProvider.getUserData();
    final GroupProvider _groupProvider = GroupProvider();
    if (user != null) {
      _studentStream = _groupProvider.getStudents(
        user.school_id,
        widget.group.group_id,
      );
      setState(() {});
    }
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
        body: StreamBuilder<List<StudentModel>>(
          stream: _studentStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? Padding(
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
                                borderRadius: BorderRadius.circular(10)),
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
                                // var student = groupProvider.students[index];
                                StudentModel student = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
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
                                  onLongPress: () {
                                    // _showDialog(context, student.uid);
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
                  )
                : Container();
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
