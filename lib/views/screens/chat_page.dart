import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/permissions.dart';
import 'package:chat_app/services/user_authentication.dart';
import 'package:chat_app/views/widgets/bottom_sheet.dart';
import 'package:chat_app/views/widgets/custom_bubble_for%20sender.dart';
import 'package:chat_app/views/widgets/custom_bubble_for_receiver.dart';
import 'package:chat_app/views/widgets/custom_textfield.dart';
import 'package:chat_app/views/widgets/google_maps.dart';
import 'package:chat_app/views/widgets/google_maps_for_receivers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/provider/user_provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({
    super.key,
    required this.username,
    required this.receiverID,
  });

  final TextEditingController message = TextEditingController();
  final ChatService chatService = ChatService();
  final UserAuthentication userAuthentication = UserAuthentication();
  final Permissions permissions = Permissions();
  final String username;
  final String receiverID;
  final ScrollController scrollController = ScrollController();

  void sendMessage() async {
    if (message.text.isNotEmpty) {
      await chatService.sendMessage(receiverID, message.text);
    }
    message.clear();
    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 3), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 3),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = Provider.of<UserProvider>(context,listen: false).phoneNumber;
    print(phoneNumber);
    print(receiverID);
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: chatPageAppbar(context),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: chatService.getMessages(receiverID, phoneNumber),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(""),
                        );
                      }
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => scrollToBottom());
                      return ListView(
                        controller: scrollController,
                        children: snapshot.data!.docs
                            .map((doc) => buildMessage(doc))
                            .toList(),
                      );
                    })),
            buildUserInput(context)
          ],
        ));
  }

  AppBar chatPageAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          )),
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      title: Text(
        username,
        style: AppStyle.poppins400style16.copyWith(color: AppColors.whiteColor),
      ),
    );
  }

  Widget buildMessage(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data["senderID"] == userAuthentication.auth.currentUser!.uid;

    if (data["message"].toString().contains("https://www.google.com/maps?q=")) {
      return locationMessage(data, isCurrentUser);
    }
    return isCurrentUser
        ? CustomBubbleForOthers(
            message: data["message"],
          )
        : CustomBubble(
            message: data["message"],
          );
  }

  Widget locationMessage(Map<String, dynamic> data, bool isCurrentUser) {
    String query = data["message"].split('q=')[1];
    List<String> coordinates = query.split(',');
    double latitude = double.parse(coordinates[0]);
    double longitude = double.parse(coordinates[1]);
    return isCurrentUser
        ? LocationMessageForOthers(latitude: latitude, longitude: longitude)
        : LocationMessage(latitude: latitude, longitude: longitude);
  }

  Widget buildUserInput(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => showAttachmentOptions(context),
          icon: const Icon(
            Icons.add,
            color: AppColors.whiteColor,
          ),
        ),
        Expanded(
            child: CustomFormTextField(
          hint: "Type a message",
          keyboardType: TextInputType.emailAddress,
          controller: message,
          isObscureText: false,
        )),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: AppColors.whiteColor,
            ))
      ],
    );
  }

  void showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AttachmentOptions(receiverID: receiverID);
      },
    );
  }
}
