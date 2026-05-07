import 'package:flutter/material.dart';
import 'package:my_deposit/utils/custom/widget/auth/animated_orb.dart';

class VibrantBackground extends StatelessWidget {
  const VibrantBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black, // Bright background to highlight glass effect
      child: Stack(
        children: [
          // Top Left Cyan Orbit - Large radial gradient
          // Positioned off-screen to create an atmospheric blend effect
          Positioned(
            top: -400,
            left: -0,
            child: AnimatedOrb(color: const Color.fromRGBO(24, 255, 243, 0.3)),
          ),

          // Bottom Right Cyan Orbit - Complementary gradient
          // Creates balance in the composition
          Positioned(
            bottom: -50,
            right: -30,
            child: AnimatedOrb(
              color: const Color.fromRGBO(185, 246, 255, 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
