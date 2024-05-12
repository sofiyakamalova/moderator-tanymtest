import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/student_provider.dart';

class StudentDetailsPage extends StatefulWidget {
  final String student_uid;
  const StudentDetailsPage({super.key, required this.student_uid});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    initStudentLoading();
    super.initState();
  }

  Future<void> initStudentLoading() async {
    try {
      await Provider.of<StudentProvider>(context, listen: false)
          .getStudentInfo(widget.student_uid);
    } catch (e) {
      print("Ошибка при загрузке данных о студенте: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Данные о студенте',
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white_color,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Consumer<StudentProvider>(
          builder: (context, studentProvider, child) {
            var student = studentProvider.student;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: student!.name),
                  CommonText(text: student.email),
                  CommonText(text: student.phone),
                  CommonText(text: student.gender),
                  //CommonText(text: student.),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
