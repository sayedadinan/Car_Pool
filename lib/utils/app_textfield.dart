import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // Adjust the radius here
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: const Color.fromARGB(255, 104, 13, 7),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class AppTextFieldForModal extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;

  const AppTextFieldForModal({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // Adjust the radius here
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: const Color.fromARGB(255, 104, 13, 7),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
