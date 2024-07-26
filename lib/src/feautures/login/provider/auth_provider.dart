import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
