import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/results/model/result_model.dart';

class ResultProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ResultModel>> getResults(String studentId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(studentId)
          .collection('result')
          .get();

      List<ResultModel> newResults = snapshot.docs
          .map(
              (doc) => ResultModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return newResults; // Return the list of results
    } catch (e) {
      print("Error loading results: $e");
      return []; // Return an empty list on error
    }
  }

  // Future<void> getStudents(String studentId) async {
  //   try {
  //     QuerySnapshot groupSnapshot = await _firestore
  //         .collection('users')
  //         .doc(schoolId)
  //         .collection('groups')
  //         .get();
  //
  //     List<GroupModel> loadedGroups = [];
  //     for (var groupDoc in groupSnapshot.docs) {
  //       var data = groupDoc.data();
  //       if (data == null) continue;
  //
  //       var groupData = data as Map<String, dynamic>;
  //
  //       var studentsSnapshot =
  //       await groupDoc.reference.collection('students').get();
  //
  //       List<StudentModel> students = studentsSnapshot.docs
  //           .map((studentDoc) => StudentModel.fromJson(
  //           studentDoc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //       GroupModel group = GroupModel(
  //         group_id: groupData['group_id'] ?? 'Нету id',
  //         group_name: groupData['group_name'] ?? 'Нету названия группы',
  //         group_curator: groupData['group_curator'] ?? 'Нет данных о кураторе',
  //         students: students,
  //       );
  //       loadedGroups.add(group);
  //     }
  //     groups = loadedGroups;
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error loading groups and students: $e");
  //   }
  // }

  String determineZone(ResultModel result) {
    // Определяем зону искренности
    String zoneSincerity = result.sincerity <= 3
        ? "red"
        : result.sincerity <= 7
            ? "yellow"
            : "green";

    // Определяем зону депрессивности
    String zoneDepression = result.depression <= 7
        ? "green"
        : result.depression <= 16
            ? "yellow"
            : "red";

    // Определяем зону невротизации
    String zoneNeuroticism = result.neuroticism <= 7
        ? "green"
        : result.neuroticism <= 16
            ? "yellow"
            : "red";

    // Определяем зону общительности
    String zoneSociability = result.sociability <= 7
        ? "red"
        : result.sociability <= 16
            ? "yellow"
            : "green";

    // Финальное определение зоны
    List<String> zones = [
      zoneSincerity,
      zoneDepression,
      zoneNeuroticism,
      zoneSociability
    ];
    return zones.contains("red")
        ? "red"
        : zones.contains("yellow")
            ? "yellow"
            : "green";
  }
}
