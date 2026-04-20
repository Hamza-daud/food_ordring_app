import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import '../mian_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  File? image;

  final String defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/crave-mate-admin.firebasestorage.app/o/avatar%2Favatar.png?alt=media&token=72df402c-e9a7-4283-96f0-b08e724e4856";

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future<String> uploadImage() async {
    if (image == null) return defaultImage;

    final ref = FirebaseStorage.instance
        .ref()
        .child("users/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await ref.putFile(image!);
    return await ref.getDownloadURL();
  }

  Future<void> signUp() async {
    try {
      if (email.text.isEmpty || password.text.isEmpty) {
        throw "Email or Password empty";
      }

      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final imageUrl = await uploadImage();

      final userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
        address: address.text.trim(),
        image: imageUrl,
      );

      await firestore
          .collection("Users")
          .doc(userModel.uid)
          .set(userModel.toMap());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    } catch (e) {
      print("SIGNUP ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _input(name, Icons.person, "Username"),
                _input(email, Icons.email, "Email"),
                _input(phone, Icons.phone, "Phone"),
                _input(address, Icons.home, "Address"),
                _input(password, Icons.lock, "Password", obscure: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signUp,
                  child: const Text("Sign Up"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: const Text("Already have account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController c,
    IconData icon,
    String label, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
