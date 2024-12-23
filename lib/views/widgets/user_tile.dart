import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.username, this.onTap});
  final String username;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: onTap,
     child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(children: [
        const Icon(Icons.person,color: AppColors.whiteColor,size: 50,),
        const SizedBox(width: 20,),
        Text(username,style: AppStyle.poppins600style18.copyWith(color: AppColors.whiteColor),)
      ],),
     ),
    );
  }
}