import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/feautures/navigation/bottom_nav_bar.dart';
import 'package:tanymtest_moderator_app/src/feautures/onboarding/onboarding_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const BottomNavBar();
          } else {
            return const OnboardingPage();
          }
        },
      ),
    );
  }
}
