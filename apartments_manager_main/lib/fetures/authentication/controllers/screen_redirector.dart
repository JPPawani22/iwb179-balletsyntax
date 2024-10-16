import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apartments_manager_main/fetures/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:apartments_manager_main/fetures/home/screen/home_screen.dart';

class ScreenReDirector {
  Widget redirectScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeScreen();
    } else {
      return const OnBoardingScreen();
    }
  }
}
