import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsers() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserId = auth.currentUser!.uid;
    String? phoneNumber = await getPhoneNumberByUserId(currentUserId);
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp,
        phoneNumber: receiverID);

    List<String> ids = [phoneNumber!, receiverID];
    String chatRoomID = generateKey(ids);
    await firestore
        .collection("ChatRooms")
        .doc(chatRoomID)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    String chatRoomID = generateKey(ids);
    return firestore
        .collection("ChatRooms")
        .doc(chatRoomID)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .handleError((error) {
      throw ('Error in Firestore Stream: $error');
    });
  }

  Future<String?> getPhoneNumberByUserId(String userId) async {
    try {
      final DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        final String phoneNumber = userDoc['number'];
        return phoneNumber;
      } else {
        print('User document does not exist.');
        return null;
      }
    } catch (e) {
      print('Error retrieving phone number: $e');
      return null;
    }
  }

  String generateKey(List<String> phoneNumbers) {
    List<String> normalizedNumbers = phoneNumbers.map((number) {
      return normalizePhoneNumber(number);
    }).toList();

    normalizedNumbers.sort();

    return normalizedNumbers.join("_");
  }

  String normalizePhoneNumber(String number) {
    String cleanedNumber = number.replaceAll(" ", "").replaceAll("-", "");

    if (!cleanedNumber.startsWith("+20")) {
      if (cleanedNumber.startsWith("0")) {
        cleanedNumber = "+20${cleanedNumber.substring(1)}";
      } else {
        cleanedNumber = "+20$cleanedNumber";
      }
    }
    return cleanedNumber;
  }
}
