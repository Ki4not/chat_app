import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/components/tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // get chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white, letterSpacing: 3.0),
        ),
      ),
      drawer: const DrawerItem(),
      body: _buildUserList(),
    );
  }

  // build user list
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error handling
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // get current user id
        final currentUserId = _authService.currentUser!.uid;

        // filter out current user
        final users = snapshot.data!.where((user) => user["uid"] != currentUserId);

        // return list view
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return _buildUserListItem(users.elementAt(index), context);
          },
        );
      },
    );
  }

  // build user list item
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
        text: userData["fname"] + " " + userData["lname"],
        onTap: () {
          // go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      name: userData["fname"] + " " + userData["lname"], receiverId: userData["uid"])));
        });
  }
}
