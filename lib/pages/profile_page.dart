import 'package:chat_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _deactivateAccount() async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Users').doc(currentUserId) .update({'isDeactivated': true});
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Account Deactivated', 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 20),),
          )
        )
      );
      await FirebaseAuth.instance.signOut();
    }
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(e.toString(), 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16)),
          )
        )
      );
    }
  }

  void _showEditProfileModal(BuildContext context, Map<String, dynamic> userData) {
    TextEditingController fnameController = TextEditingController(text: userData['fname']);
    TextEditingController lnameController = TextEditingController(text: userData['lname']);
    TextEditingController emailController = TextEditingController(text: userData['email']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: fnameController,
                  decoration: InputDecoration(labelText: 'First Name', labelStyle: TextStyle(color: Colors.blue), enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    ), focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  )
                ),
                TextField(
                  controller: lnameController,
                  decoration: InputDecoration(labelText: 'Last Name', labelStyle: TextStyle(color: Colors.blue), enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    ), focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.blue), enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    ), focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  )
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    try {
                      String userId = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
                        'fname': fnameController.text,
                        'lname': lnameController.text,
                        'email': emailController.text,
                      });
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Profile Updated', 
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 20),),
                          )
                        )
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.toString(), 
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 16),),
                          )
                        )
                      );
                    }
                  },
                  child: const Text('Save Changes', style: TextStyle(color: Colors.white),)
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue, letterSpacing: 3.0, ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userEmail,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileButton(buttonText: 'Edit Profile', buttonColor: Colors.blue, onPressed: () => _showEditProfileModal(context, userData),),
                        const SizedBox(width: 20),
                        ProfileButton(buttonText: 'Deactivate', buttonColor: Colors.red, onPressed: _deactivateAccount,),
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
