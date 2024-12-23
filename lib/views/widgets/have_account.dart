import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';


class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.haveAnAccount ,style: AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor),),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppStrings.login,
                style: AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor,decoration: TextDecoration.underline,decorationColor:AppColors.whiteColor ),))
      ],
    );
  }
}