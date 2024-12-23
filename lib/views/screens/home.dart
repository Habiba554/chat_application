import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/views/screens/home_body.dart';
import 'package:chat_app/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appBar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.primaryColor,
      appBar:  const CustomAppBar(
        title: AppStrings.home, ),
      body: HomeBody()
    );
  }
}
