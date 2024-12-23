import 'package:chat_app/constants/app_assets.dart';
import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_routes.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamed(context, Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor , 
      body: FutureBuilder(
        future: initializeApp(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                AppAssets.chat,
                width: 150, 
                height: 150, 
              ),
            );
          }
          return Container(); 
        },
      ),
    );
  }
}
