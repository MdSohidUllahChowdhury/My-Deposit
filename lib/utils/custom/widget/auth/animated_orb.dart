import 'package:flutter/material.dart';

class AnimatedOrb extends StatelessWidget {
  final Color color;
  const AnimatedOrb({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700, // Large size creates atmospheric, soft-edged orbs
      height: 900, // Perfect for creating depth and visual interest
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color, // Full intensity at center
            color.withAlpha(30), // Soft transition
            Colors.transparent, // Seamless blend into background
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
    );
  }
}
