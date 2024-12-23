import 'package:chat_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBars(BuildContext context,{required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }