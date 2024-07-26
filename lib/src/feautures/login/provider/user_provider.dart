import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/user_model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> fetchUser(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('psychologists')
        .doc(uid)
        .get();
    _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    notifyListeners();
  }
}
