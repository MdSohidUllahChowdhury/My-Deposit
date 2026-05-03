import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';
import 'package:my_deposit/utils/custom/widget/auth/custom_auth_bottom.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_logo.dart';
import 'package:my_deposit/utils/custom/widget/auth/input_field.dart';
import 'package:my_deposit/utils/custom/widget/auth/vibrant_background.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({super.key});

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
                        Text(
                          "\nCreate an account to get started",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 16,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Username input field with glass styling
                        input_field(
                          hint: "Full Name",
                          controllerName: email,
                          giveKey: emailKey,
                        ),
                        const SizedBox(height: 16),

                        input_field(
                          hint: "Email",
                          controllerName: email,
                          giveKey: emailKey,
                        ),
                        const SizedBox(height: 16),

                        // Password input field with glass styling
                        input_field(
                          hint: "Password",
                          controllerName: password,
                          giveKey: passwordKey,
                        ),
                        const SizedBox(height: 30),

                        // Login button with glass effect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_auth_bottom(
                              bottomName: "LOGIN",
                              onTap: () {
                                Get.to(
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(seconds: 1),
                                  () => LoginScreen(),
                                );
                                // Handle login logic here
                              },
                            ),
                            const SizedBox(width: 16),
                            custom_auth_bottom(
                              bottomName: "Sing UP",
                              onTap: () {},
                            ),
                          ],
                        ),
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
}
