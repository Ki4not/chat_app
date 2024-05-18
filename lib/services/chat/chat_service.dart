import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each user
        final user = doc.data();

        // return user
        return user;
      }).toList();
      }
    );
  } 

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final currentUserId = _authService.currentUser!.uid;
    final currentUserData = await _firestore.collection("Users").doc(currentUserId).get();
    final currentUserName = currentUserData.data()!["fname"] + " " + currentUserData.data()!["lname"];

    // create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderName: currentUserName,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
    );

    // create chat room ID
    List<String> members = [currentUserId, receiverId];
    members.sort();
    String chatRoomId = members.join("_");

    // save message
    await _firestore.collection("Chat_Room").doc(chatRoomId).collection("Messages").add(newMessage.toMap());

  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherId){
    // create chat room ID
    List<String> members = [userId, otherId];
    members.sort();
    String chatRoomId = members.join("_");

    // get messages
    return _firestore.collection("Chat_Room").doc(chatRoomId).collection("Messages").orderBy("timestamp", descending: false).snapshots();
  }

  // edit message
  Future<void> editMessage(String messageId, String newMessage) async {
    final currentUserId = _authService.currentUser!.uid;
    String SenderId = _authService.currentUser!.uid;

    if (currentUserId == SenderId) {
      await _firestore
          .collection("Chat_Room")
          .doc(messageId)
          .update({"message": newMessage});
    }
  }

}

