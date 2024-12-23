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
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    await firestore
        .collection("ChatRooms")
        .doc(chatRoomID)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID,  otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();

    String chatRoomID = ids.join('_');
   
    return firestore
      .collection("ChatRooms")
      .doc(chatRoomID)
      .collection("Messages")
      .orderBy("timestamp", descending: false)
      .snapshots()
      .handleError((error) {
        throw('Error in Firestore Stream: $error');
      });
  }
  
}
