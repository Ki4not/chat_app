import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String buttonText;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function()? onPressed;

  const ProfileButton({super.key, required this.buttonText, required this.buttonColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, 
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
      ),
      child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 16),),     
      );
  }
}