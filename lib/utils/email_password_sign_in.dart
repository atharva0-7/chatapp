
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EmailPasswordAuthentication {
//   createUser(String emailAddress, String password, BuildContext context) async {
//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );

    
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("The password provided is too weak.")));
//       } else if (e.code == 'email-already-in-use') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("The account already exists for that email.")));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   signInUser(String emailAddress, String password, BuildContext context) async {
//     try {
//       final credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: emailAddress, password: password);
//       print("user Logged in");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("'No user found for that email.")));

//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Wrong password provided for that user.")));
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
// }
