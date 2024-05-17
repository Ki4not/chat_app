import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  void signOut() {
    // auth service
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text('MENU', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 3.0)),
                )
              ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,0),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.house, color: Colors.blue),
              title: const Text('HOME', style: TextStyle(letterSpacing: 5.0),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,0),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.gear, color: Colors.blue),
              title: const Text('SETTINGS', style: TextStyle(letterSpacing: 5.0),),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
          ),],

          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,15),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.rightFromBracket, color: Colors.blue),
              title: const Text('LOGOUT', style: TextStyle(letterSpacing: 5.0),),
              onTap: () => signOut(),
            ),
          ),
        ],
      ),
    );
  }
}