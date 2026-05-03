import 'package:flutter/material.dart';

// ignore: camel_case_types
class input_field extends StatelessWidget {
  const input_field({
    super.key,
    required this.hint,
    required this.controllerName,
    required this.giveKey,
  });

  final String hint;
  final TextEditingController controllerName;
  final Key giveKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controllerName,
        key: giveKey,
        decoration: InputDecoration(
          prefixIcon: Icon(
            hint == "Email"
                ? Icons.email
                : hint == "Full Name"
                ? Icons.person
                : Icons.lock,
            color: const Color.fromRGBO(255, 255, 255, 0.54),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.54),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
