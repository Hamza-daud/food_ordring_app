import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/All_Screens/auth_Screen/login_screen.dart';

import 'package:food_ordering_app/All_Screens/mian_screen.dart';

class UserCheck extends StatelessWidget {
  const UserCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ⏳ Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ USER LOGGED IN
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // ❌ USER NOT LOGGED IN
        return const LoginScreen();
      },
    );
  }
}
