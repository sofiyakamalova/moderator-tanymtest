import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StudentModel? student;

  Future<void> getStudentInfo(String studentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(studentId).get();

      if (snapshot.exists && snapshot.data() != null) {
        student =
            StudentModel.fromJson(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
      } else {
        print("Документ не найден.");
      }
    } catch (e) {
      print("Ошибка при получении информации о студенте: $e");
    }
  }
}
