import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_routes.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';


class NoAccount extends StatelessWidget {
  const NoAccount({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          AppStrings.noAccount,
          style:  AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.signUpRoute);
          },
          child: Text(
            AppStrings.signup,
            style: AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor,decoration: TextDecoration.underline,decorationColor:AppColors.whiteColor ),
          ),
        )
      ],
    );
  }
}