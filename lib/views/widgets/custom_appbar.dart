import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title,});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: MediaQuery.of(context).size.width < 1024
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Semantics(
                  label: "OPen drawer",
                  tooltip: "Open app drawer",
                  child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu, color: AppColors.whiteColor))))
          : null,
      backgroundColor: AppColors.primaryColor,
      title: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              maxLines: 3,
              title,
              style: AppStyle.poppins400style16
                  .copyWith(color: AppColors.whiteColor)),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
