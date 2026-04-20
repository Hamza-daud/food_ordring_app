
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/All_Screens/auth_Screen/signup_Screen.dart';
// import 'package:food_ordering_app/All_Screens/mian_screen.dart';

// class LoginScreen extends StatelessWidget {
//   final email = TextEditingController();
//   final password = TextEditingController();

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: _glassCard(
//               child: Column(
//                 children: [
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(
//                       fontSize: 28,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   _input(email, Icons.email, "Email"),
//                   const SizedBox(height: 15),

//                   _input(password, Icons.lock, "Password", obscure: true),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Forgot Password?",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 10),
//                   _button(
//                     "Log In",
//                     onTap: () {
//                       final FirebaseAuth auth = FirebaseAuth.instance;
//                       auth.signInWithEmailAndPassword(
//                         email: email.text,
//                         password: password.text,
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MainScreen()),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpScreen()),
//                       );
//                     },
//                     child: const Text(
//                       "Don't have an account? Sign Up",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _glassCard({required Widget child}) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.white.withOpacity(0.2)),
//         ),
//         child: child,
//       ),
//     );
//   }

//   Widget _input(
//     TextEditingController c,
//     IconData icon,
//     String label, {
//     bool obscure = false,
//   }) {
//     return TextField(
//       controller: c,
//       obscureText: obscure,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.white70),
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.1),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _button(String text, {required VoidCallback onTap}) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.teal.shade800,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }