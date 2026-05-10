import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// ignore: must_be_immutable, camel_case_types
class input_field extends StatelessWidget {
  input_field({
    super.key,
    required this.hint,
    required this.controllerName,
    this.giveKey,
  });

  final String hint;
  final TextEditingController controllerName;
  Key? giveKey;

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
                ? Icons.email_outlined
                : hint == "Number"
                ? Iconsax.call_copy
                : Icons.lock_outline_rounded,
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
