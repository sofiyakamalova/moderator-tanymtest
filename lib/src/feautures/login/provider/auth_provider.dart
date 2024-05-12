import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/psychologist_model.dart';

class AuthProvider extends ChangeNotifier {
  // Instance for authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Instance for Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Creating document if it doesn't already exist
      _firestore.collection('psychologists').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'password': password,
      }, SetOptions(merge: true));
      print(userCredential.user!.uid);
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error signing in: ${e.message}');
      throw Exception('Failed to sign in with email and password: ${e.code}');
    }
  }

  //Get school ID
  Future<String> fetchSchoolId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('psychologists')
          .doc(user.uid)
          .get();

      if (!snapshot.exists) {
        throw Exception("Документ для пользователя не найден.");
      }
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey('school_id')) {
        throw Exception(
            "Поле 'school_id' не найдено в документе пользователя.");
      }
      String? schoolId = data['school_id'] as String?;
      if (schoolId == null) {
        throw Exception("Поле 'school_id' пусто или неверного типа.");
      }
      return schoolId;
    } else {
      throw Exception("Пользователь не авторизован");
    }
  }

//get user
  Future<PsychologistModel?> getUserData() async {
    try {
      User? firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot userSnapshot = await _firestore
            .collection('psychologists')
            .doc(firebaseUser.uid)
            .get();
        if (userSnapshot.exists) {
          return PsychologistModel.fromJson(
              userSnapshot.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
