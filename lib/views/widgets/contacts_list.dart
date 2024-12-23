import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';

class ContactListBottomSheet extends StatelessWidget {
  final List<Contact> contacts;
  final Function(Contact) onContactSelected;

  const ContactListBottomSheet({
    super.key,
    required this.contacts,
    required this.onContactSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            leading: const Icon(Icons.person, color: AppColors.whiteColor),
            title: Text(
              contact.displayName,
              style: AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor),
            ),
            subtitle: contact.phones.isNotEmpty
                ? Text(contact.phones.first.number)
                : const Text("No phone number available"),
            onTap: () {
              Navigator.pop(context);
              onContactSelected(contact);
            },
          );
        },
      ),
    );
  }
}
