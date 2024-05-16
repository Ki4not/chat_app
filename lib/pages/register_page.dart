import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function() onTap;

  RegisterPage({super.key, required this.onTap});

  register() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // icon
          const Icon(
            FontAwesomeIcons.message,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 50,
          ),
          // register text
          const Text(
            'Join us by creating an account!',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          // username textfield
          LoginTextField(
              hintText: 'Username',
              icon: FontAwesomeIcons.user,
              hideText: false,
              controller: _usernameController),
          // password textfield
          const SizedBox(
            height: 20,
          ),
          LoginTextField(
              hintText: 'Password',
              icon: FontAwesomeIcons.lock,
              hideText: true,
              controller: _passwordController),
          const SizedBox(
            height: 20,
          ),
          // signup button
          CustomButton(
            buttonText: 'Sign Up',
            onTap: register,
          ),
          const SizedBox(
            height: 10,
          ),
          // sign in redirect
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text('Sign In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
