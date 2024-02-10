import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/barCode/barcode.dart';
import '../pages/login2.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password, String fullName, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Do something after user sign-up if needed

      Fluttertoast.showToast(msg: "Account created successfully :) ");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login2()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error during sign up: $e');
      }
    } catch (e) {
      print('Unexpected error during sign up: $e');
    }
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If sign-in is successful, navigate to the home page or any desired page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarcodeApp()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Error during sign in: $e');
      }

      // You can show relevant error messages to the user using Fluttertoast or other UI components
      Fluttertoast.showToast(msg: "Sign-in failed. Please check your credentials.");
    } catch (e) {
      print('Unexpected error during sign in: $e');
    }
  }
}
