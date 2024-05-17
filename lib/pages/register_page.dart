import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final void Function() onTap;

  RegisterPage({super.key, required this.onTap});

  register(BuildContext context) async {
    // auth service
    final authService = AuthService();

    final fname = _fnameController.text;
    final lname = _lnameController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (fname.isEmpty || lname.isEmpty || username.isEmpty || password.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Please fill in all fields'),
              ));
      return;
    }

    try {
      await authService.signUpWithEmailAndPassword(
          _usernameController.text, _passwordController.text, _fnameController.text, _lnameController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
            // firstname textfield
            LoginTextField(
                hintText: 'First Name',
                hideText: false,
                controller: _fnameController),
            const SizedBox(
              height: 20,
            ),
            // lastname textfield
            LoginTextField(
                hintText: 'Last Name',
                hideText: false,
                controller: _lnameController),
            const SizedBox(
              height: 20,
            ),
            //username textfield
            LoginTextField(
                hintText: 'Username',
                hideText: false,
                controller: _usernameController),
            // password textfield
            const SizedBox(
              height: 20,
            ),
            LoginTextField(
                hintText: 'Password',
                hideText: true,
                controller: _passwordController),
            const SizedBox(
              height: 20,
            ),
            // signup button
            CustomButton(
              buttonText: 'Sign Up',
              onTap: () => register(context),
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
      ),
    );
  }
}
