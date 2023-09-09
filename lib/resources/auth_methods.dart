import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up users
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String imgUrl =
            await StorageMethods().uploadToStorage('userProfile', file, false);

        // Add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "username": username,
          "email": email,
          "bio": bio,
          "followers": [],
          "following": [],
          "imageUrl": imgUrl,
        });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
