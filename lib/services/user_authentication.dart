import 'dart:async';

import 'package:chat_app/constants/app_routes.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/views/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/provider/user_provider.dart';

class UserAuthentication {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ChatService chatService = ChatService();

  Future<void> loginUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        showSnackBars(msg: AppStrings.loginSuccess, context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.homeRoute,
          (Route<dynamic> route) => false,
        );
      } else {
        showSnackBars(msg: 'Please verify your email', context);
        await FirebaseAuth.instance.signOut();
      }

      String? phoneNumber =
          await chatService.getPhoneNumberByUserId(userCredential.user!.uid);
      Provider.of<UserProvider>(context, listen: false)
          .setPhoneNumber(phoneNumber!);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        showSnackBars(msg: AppStrings.wrongEmailOrPassword, context);
      }
    } catch (ex) {
      showSnackBars(msg: ex.toString(), context);
    }
  }

  Future<void> registerUser(BuildContext context, String emailAddress,
      String password, String phoneNumber) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        showSnackBars(
            msg: "Signup successful! Please verify your email address.",
            context);
      }
      Navigator.pop(context);
      await firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': emailAddress,
        'number': "0$phoneNumber"
      });
      Provider.of<UserProvider>(context, listen: false)
          .setPhoneNumber("0$phoneNumber");
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
