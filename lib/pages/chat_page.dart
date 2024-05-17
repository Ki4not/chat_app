import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String name;
  const ChatPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
