import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/screens/splash_screen.dart';

import '../controller/google_signup_and_logout.dart';
import 'signup_page.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            Get.put(GoogleSignUp());
            return const LoginPage();
          }
        }
      },
    );
  }
}
