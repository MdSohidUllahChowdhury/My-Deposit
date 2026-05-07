import 'package:flutter/material.dart';

class GlassLogo extends StatelessWidget {
  const GlassLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.2),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(138, 214, 209, 209),
            blurRadius: 10,
            spreadRadius: 1.3,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'lib/asset/logo.png',
        width: 80,
        height: 80,
        fit: BoxFit.contain,
      ),
    );
  }
}
