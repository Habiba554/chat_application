import 'dart:async';

import 'package:chat_app/constants/app_routes.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/views/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthentication {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  
  Future<void> loginUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email':emailAddress
        }
      );
      showSnackBars(msg: AppStrings.loginSuccess, context);
      Navigator.pushNamed(context, Routes.homeRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        showSnackBars(msg: AppStrings.wrongEmailOrPassword, context);
      }
    } catch (ex) {
      showSnackBars(msg: ex.toString(), context);
    }
  }

 Future<void> registerUser(
    BuildContext context, String emailAddress, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    await userCredential.user?.sendEmailVerification();
    Navigator.pop(context); 
    showSnackBars(
        msg: "Signup successful! Please verify your email address.", context);


    await firestore.collection("Users").doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': emailAddress,
    });
    
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showSnackBars(msg: AppStrings.weakPassword, context);
    } else if (e.code == 'email-already-in-use') {
      showSnackBars(msg: AppStrings.accountExistsForEmail, context);
    }
  } catch (ex) {
    showSnackBars(msg: ex.toString(), context);
  }
}

  Future<void> signOut(
    BuildContext context,
  ) async {
    try {
      await auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
        (Route<dynamic> route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully logged out")),
      );
    } catch (ex) {
      showSnackBars(msg: ex.toString(), context);
    }
  }
}
