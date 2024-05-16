import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function() onTap;

  LoginPage({super.key, required this.onTap});

  void login(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon
            const Icon(FontAwesomeIcons.message, size: 100, color: Colors.blue,),
            const SizedBox(height: 50,),
            // app name
            const Text('Chat App', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),),
            const SizedBox(height: 20,),
            // username textfield
            LoginTextField(
              hintText: 'Username', 
              icon: FontAwesomeIcons.user, 
              hideText: false,
              controller: _usernameController
            ),
            // password textfield
            const SizedBox(height: 20,),
            LoginTextField(
              hintText: 'Password', 
              icon: FontAwesomeIcons.lock, 
              hideText: true,
              controller: _passwordController
            ),
            const SizedBox(height: 20,),
            // login button
            CustomButton(buttonText: 'Sign In', onTap: login,),
            const SizedBox(height: 10,),
            // sign up redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? ', style: TextStyle(fontSize: 16),),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              ],
            ),
          ]
        ),
      ),
    );
  }
}