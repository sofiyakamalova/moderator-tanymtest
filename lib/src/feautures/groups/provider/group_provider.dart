import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';

class GroupProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<GroupModel> groups = [];

  Stream<List<GroupModel>> getGroups(String schoolId) {
    try {
      return _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .snapshots()
          .asyncMap((snapshot) async {
        List<GroupModel> groups = [];
        for (var doc in snapshot.docs) {
          var groupData = doc.data() as Map<String, dynamic>;
          var studentsSnapshot =
              await doc.reference.collection('students').get();
          var studentsData = studentsSnapshot.docs
              .map((studentDoc) => StudentModel.fromJson(
                  studentDoc.data() as Map<String, dynamic>))
              .toList();

          GroupModel group = GroupModel(
            group_id: groupData['group_id'] ?? 'Нет id',
            group_name: groupData['group_name'] ?? 'Не найдено',
            group_curator:
                groupData['group_curator'] ?? 'Нет данных о кураторе',
            students: studentsData,
          );

          groups.add(group);
        }
        return groups;
      });
    } catch (e) {
      print("Error loading groups and students: $e");
      throw e;
    }
  }

//get students
  List<StudentModel> students = [];

  Stream<List<StudentModel>> getStudents(String schoolId, String groupId) {
    try {
      return FirebaseFirestore.instance
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .doc(groupId)
          .collection('students')
          .orderBy('name', descending: false)
          .snapshots()
          .map((snapshot) {
        List<StudentModel> students = [];
        for (var doc in snapshot.docs) {
          students
              .add(StudentModel.fromJson(doc.data() as Map<String, dynamic>));
        }
        return students;
      });
    } catch (e) {
      print("Error loading students: $e");
      throw e;
    }
  }

  Future<void> addGroup(
      String schoolId, String groupName, String curatorName) async {
    try {
      DocumentReference docRef = await _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .add({
        'group_name': groupName,
        'curator_name': curatorName,
      });

      await docRef.update({'group_id': docRef.id});
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add group: $e');
    }
  }

  Future<void> deleteGroup(String schoolId, String groupId) async {
    try {
      DocumentReference docRef = _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .doc(groupId);

      await docRef.delete();

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete group: $e');
    }
  }



  Future<void> registerStudent({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String schoolId,
    required String gender,
    required String groupId,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      await addStudents(
        schoolId: schoolId,
        groupId: groupId,
        name: name,
        email: email,
        phone: phone,
        password: password,
        gender: gender,
        uid: userId,
      );

      print("Студент успешно зарегистрирован: $userId");

    } catch (e) {
      print("Ошибка при регистрации студента: $e");

      throw Exception('Failed to register student: $e');
    }
  }

  Future<void> addStudents({
    required String schoolId,
    required String groupId,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String gender,
    required String uid,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'gender': gender,
      'uid': uid,
      'group_id': groupId,
      'school_id': schoolId,
    });
    await _firestore
        .collection('schools')
        .doc(schoolId)
        .collection('groups')
        .doc(groupId)
        .collection('students')
        .doc(uid)
        .set({
      'name': name,
      'uid': uid,
    });
  }

  Future<void> deleteStudent(
    String schoolId,
    String groupId,
    String uid,
  ) async {
    try {
      await _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .doc(groupId)
          .collection('students')
          .doc(uid)
          .delete();

      await _firestore.collection('users').doc(uid).delete();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete group: $e');
    }
  }
}
