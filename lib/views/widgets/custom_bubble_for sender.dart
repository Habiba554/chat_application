import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: AppColors.greyColor,
          ),
          child: Text(message,
              style: AppStyle.poppins400style16.copyWith(
                color: AppColors.whiteColor,
              ),
              softWrap: true,
              overflow: TextOverflow.visible)),
    );
  }
}
