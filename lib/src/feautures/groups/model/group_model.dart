import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';

class GroupModel {
  final String group_id;
  final String group_name;
  final List<StudentModel> students;
  final String group_curator;
  GroupModel({
    required this.group_id,
    required this.group_name,
    required this.students,
    required this.group_curator,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    var studentsList = json['students'] as List?;
    List<StudentModel> students = [];

    if (studentsList != null) {
      students = studentsList
          .map((s) => StudentModel.fromJson(s as Map<String, dynamic>))
          .toList();
    }

    return GroupModel(
      group_id: json['group_id'] ?? 'no id',
      group_name: json['group_name'] ?? 'no group name',
      group_curator: json['group_curator'] ?? 'no group curator',
      students: students,
    );
  }
}
