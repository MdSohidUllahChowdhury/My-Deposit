import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_logo.dart';
import 'package:my_deposit/utils/custom/widget/auth/vibrant_background.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final email = TextEditingController();
  final password = TextEditingController();
  final emailKey = const Key("email");
  final passwordKey = const Key("password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const VibrantBackground(),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GlassLogo(),
                  const SizedBox(height: 30),
                  GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "My  Deposit",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Track your finances with style and clarity ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 13,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Username input field with glass styling
                        _buildGlassInput("Email", email, emailKey),
                        const SizedBox(height: 16),

                        // Password input field with glass styling
                        _buildGlassInput("Password", password, passwordKey),
                        const SizedBox(height: 30),

                        // Login button with glass effect
                        _buildGlassButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a glass-styled input field with frosted glass appearance

  Widget _buildGlassInput(
    String hint,
    TextEditingController controllerName,
    Key giveKey,
  ) {
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

  /// Builds a glass-styled button with frosted glass appearance

  Widget _buildGlassButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Log in botton
        Container(
          width: 140,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.2)),
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                // Handle login logic here
              },
              child: Text(
                "LOGIN",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),

        // SingUp botton
        const SizedBox(width: 16),
        Container(
          width: 140,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(198, 149, 211, 3),
            borderRadius: BorderRadius.circular(15),
            //border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.2)),
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                print("Sign Up button tapped");
                // Handle login logic here
              },
              child: Text(
                "SIGN UP",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
