import 'package:flutter/material.dart';

/// Glass Logo Component
class GlassLogo extends StatelessWidget {
  const GlassLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        // Semi-transparent white (20% opacity) for frosted glass look
        color: const Color.fromRGBO(255, 255, 255, 0.2),
        shape: BoxShape.circle,
        // Subtle border (30% opacity) to define the circular shape
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.3)),
      ),
      child: const Icon(Icons.blur_on, color: Colors.white, size: 40),
    );
  }
}
