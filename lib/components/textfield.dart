import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool hideText;
  final TextEditingController controller;
  
  const LoginTextField({
    super.key, 
    required this.hintText, 
    this.icon, 
    required this.hideText, 
    required this.controller}
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: hideText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          hintText: hintText,
          prefixIcon: icon != null ? Icon(icon, color: Colors.blue,) : null,
        ),
      ),
    );
  }
}
