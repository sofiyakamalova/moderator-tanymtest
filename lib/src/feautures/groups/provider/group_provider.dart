import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/student_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/user_model/user_model.dart';

class GroupProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<GroupModel> groups = [];
  String schoolId = '';

  Future<void> initialize() async {
    await _getCurrentUserSchoolId();
    notifyListeners();
  }

  Future<void> _getCurrentUserSchoolId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('psychologists').doc(user.uid).get();
        if (userDoc.exists) {
          UserModel currentUser =
              UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          schoolId = currentUser.school_id;
        }
      }
    } catch (e) {
      print("Error getting current user school_id: $e");
      throw e;
    }
  }

  Stream<List<GroupModel>> getGroups() {
    if (schoolId.isEmpty) {
      return Stream.error("School ID is not set.");
    }

    try {
      return _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('groups')
          .snapshots()
          .asyncMap((snapshot) async {
        List<GroupModel> groups = [];
        for (var doc in snapshot.docs) {
          var groupData = doc.data();
          var studentsSnapshot =
              await doc.reference.collection('students').get();
          var studentsData = studentsSnapshot.docs
              .map((studentDoc) => StudentModel.fromJson(studentDoc.data()))
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

  Future<void> addGroup(String groupName, String curatorName) async {
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

  Stream<List<StudentModel>> getStudents(String groupId) {
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
}
