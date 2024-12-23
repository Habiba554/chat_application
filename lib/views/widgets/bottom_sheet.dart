import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:chat_app/services/permissions.dart';


class AttachmentOptions extends StatelessWidget {
  final String receiverID;

  AttachmentOptions({super.key, required this.receiverID});
  final ChatService chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.location_on, color: AppColors.whiteColor),
            title: Text(
              AppStrings.sendLocation,
              style: AppStyle.poppins400style14
                  .copyWith(color: AppColors.whiteColor),
            ),
            onTap: () {
              Navigator.pop(context);
              Permissions().sendLocation(receiverID);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: AppColors.whiteColor),
            title: Text(
              AppStrings.sendContact,
              style: AppStyle.poppins400style14
                  .copyWith(color: AppColors.whiteColor),
            ),
            onTap: () {
              Navigator.pop(context);
              Permissions().chooseContact(context, receiverID);
            },
          ),
        ],
      ),
    );
  }
}
