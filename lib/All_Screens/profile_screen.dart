import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/auth_Screen/login_screen.dart';
import 'package:food_ordering_app/All_Screens/splash.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  // 🔥 LOGOUT FUNCTION
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,

        // 🔴 LOGOUT BUTTON
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection("Users").doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User not found"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(data["image"]),
                ),
                const SizedBox(height: 20),
                Text(
                  data["name"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                profileTile(Icons.email, data["email"]),
                profileTile(Icons.phone, data["phone"]),
                profileTile(Icons.home, data["address"]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget profileTile(IconData icon, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(value),
      ),
    );
  }
}
