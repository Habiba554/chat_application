import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/permissions.dart';
import 'package:chat_app/services/user_authentication.dart';
import 'package:chat_app/views/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final auth = FirebaseAuth.instance;
  final ChatService chatService = ChatService();
  final Permissions permissions = Permissions();
  final UserAuthentication userAuthentication = UserAuthentication();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: permissions.getAllContects(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("There is an error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final phoneNumber = snapshot.data![index].phones.isNotEmpty
                  ? snapshot.data![index].phones.first.number
                  : "No Phone Number";
              return ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            username: snapshot.data![index].displayName,
                            receiverID: phoneNumber,
                          )),
                ),
                title: Text(
                  snapshot.data![index].displayName,
                  style: AppStyle.poppins600style18
                      .copyWith(color: AppColors.whiteColor),
                ),
                subtitle: Text(
                  phoneNumber,
                  style: AppStyle.poppins400style16
                      .copyWith(color: AppColors.whiteColor),
                ),
                leading: const Icon(
                  Icons.person,
                  color: AppColors.whiteColor,
                  size: 50,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: AppColors.whiteColor,
                thickness: 1.0,
                indent: 20.0,
                endIndent: 20.0,
              );
            },
          );
        });
  }
}
