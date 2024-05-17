import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white) ,
        backgroundColor: Colors.blue,
        title: const Text('SETTINGS', style: TextStyle(color: Colors.white),), 
      ),
    );
  }
}