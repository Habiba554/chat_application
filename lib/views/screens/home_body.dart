import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/user_authentication.dart';
import 'package:chat_app/views/screens/chat_page.dart';
import 'package:chat_app/views/widgets/user_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final auth = FirebaseAuth.instance;
  final ChatService chatService = ChatService();
  final UserAuthentication userAuthentication = UserAuthentication();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("There is an error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!
                .map((userData) => buildListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget buildListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != auth.currentUser!.email) {
      return UserTile(
          username: userData["email"],
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          username: userData["email"],
                          receiverID: userData["uid"],
                        )),
              ));
    } else {
      return Container();
    }
  }
}
