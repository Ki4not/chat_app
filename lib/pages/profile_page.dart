import 'package:chat_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'PROFILE',
          style: TextStyle(color: Colors.white, letterSpacing: 3.0),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No user data found.'));
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            var userName = '${userData['fname'] ?? 'FirstName'} ${userData['lname'] ?? 'LastName'}';
            var userEmail = userData['email'] ?? 'user@example.com';
            return Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue, letterSpacing: 3.0),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userEmail,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileButton(buttonText: 'Edit Profile', buttonColor: Colors.blue),
                        SizedBox(width: 20),
                        ProfileButton(buttonText: 'Deactivate', buttonColor: Colors.red),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
