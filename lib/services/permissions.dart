import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/views/widgets/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  final ChatService chatService = ChatService();
  void sendLocation(String receiverID) async {
    Location location = Location();

    bool serviceEnabled;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }
    locationData = await location.getLocation();

    String locationMessage =
        "https://www.google.com/maps?q=${locationData.latitude},${locationData.longitude}";

    await chatService.sendMessage(receiverID, locationMessage);
  }

  void chooseContact(BuildContext context, String receiverID) async {
    final permission = await Permission.contacts.request();
    if (!permission.isGranted) return;

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    if (contacts.isNotEmpty) {
      print(contacts);
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ContactListBottomSheet(
            contacts: contacts,
            onContactSelected: (contact) {
              sendContact(contact, receiverID);
            },
          );
        },
      );
    }
  }

  void sendContact(Contact contact, String receiverID) async {
    String contactInfo =
        "Name: ${contact.displayName}, Phone: ${contact.phones.isNotEmpty ? contact.phones.first.number : 'No phone number'}";
    await chatService.sendMessage(receiverID, contactInfo);
  }
}
