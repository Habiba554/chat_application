
import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_routes.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:chat_app/services/user_authentication.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, this.onTap, this.currentIndex});
  final ValueChanged<int>? onTap;
  final int? currentIndex;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    UserAuthentication userAuthentication=UserAuthentication();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(child: Column(
            children: [
              IconButton(
                onPressed: ()=>Navigator.pushNamed(context, Routes.profileRoute), 
                icon: const Icon(Icons.person,color: AppColors.whiteColor,size: 70,)),
                Text(AppStrings.profile,style: AppStyle.poppins400style16.copyWith(color: AppColors.whiteColor),)
            ],
          )),
          SizedBox(height: mediaQuery.size.height * 0.09),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, left: 25.0),
            child: ListTile(
              onTap:()=> userAuthentication.signOut(context),
              title: Text(
                AppStrings.logOut,
                style: AppStyle.poppins400style16
                    .copyWith(color: AppColors.whiteColor),
              ),
              leading: const Icon(
                Icons.logout_outlined,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
