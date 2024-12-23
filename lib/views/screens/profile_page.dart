import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            )),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: AppColors.whiteColor,
                size: 70,
              ),
              Text(
                "${auth.currentUser!.email}",
                style: AppStyle.poppins600style18
                    .copyWith(color: AppColors.whiteColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
