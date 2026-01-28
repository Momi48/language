import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language/model/user_model.dart';
import 'package:language/screen/home_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔐 REGISTER
  Future<void> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create auth user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = userCredential.user!.uid;
      final user = UserModel(name: name, 
      email: email, 
      profileImage: name[0], 
      currentIndex: 0, 
      currentSentence: "");
      // Create Firestore user document
      await _firestore.collection('users').doc(uid).set(user.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful")),
      );
    } on FirebaseAuthException catch (e) {
      print('Error :${e.toString()}');
    }
  }

  /// 🔑 LOGIN
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      print('Error :${e.toString()}');
    }
  }

 Future<UserModel?> getLoggedInUser() async {
    final User? user = _auth.currentUser;

    if (user == null) return null;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return UserModel.fromJson(doc.data()!);
  }
}
