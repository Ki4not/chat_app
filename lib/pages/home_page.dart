import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    // auth service
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'), 
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
            onPressed: () => signOut(),
          ),
        ],
      ),
    );
  }
}