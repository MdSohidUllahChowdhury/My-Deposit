import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';
import 'package:my_deposit/utils/custom/widget/auth/custom_auth_bottom.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/auth/input_field.dart';
import 'package:my_deposit/utils/custom/widget/auth/vibrant_background.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({super.key});

  final name = TextEditingController();
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/asset/logo.png'),
                  ),
                  //const GlassLogo(),
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
                          controllerName: name,
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
                              },
                            ),
                            const SizedBox(width: 16),
                            custom_auth_bottom(
                              bottomName: "Confirm",
                              onTap: () async {
                                if (email.text.isEmpty ||
                                    password.text.isEmpty ||
                                    name.text.isEmpty) {
                                  Get.snackbar(
                                    "Dicline to Sign Up",
                                    "All the Fields are Required",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: const Color.fromARGB(
                                      76,
                                      244,
                                      67,
                                      54,
                                    ),
                                    colorText: Colors.white,
                                  );
                                  return;
                                }
                                try {
                                  await Supabase.instance.client.auth.signUp(
                                    email: email.text,
                                    password: password.text,
                                    //data: {"Display name": name},
                                  );
                                  await Supabase.instance.client
                                      .from('profiles')
                                      .insert({
                                        'id': Supabase
                                            .instance
                                            .client
                                            .auth
                                            .currentUser!
                                            .id,
                                        'name': name.text.trim(),
                                      });
                                  Get.snackbar(
                                    "Signup Success",
                                    "Account created successfully!",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: const Color.fromARGB(
                                      179,
                                      6,
                                      12,
                                      0,
                                    ),
                                    colorText: Colors.white,
                                  );
                                  Future.delayed(const Duration(seconds: 1));
                                  Get.to(
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(seconds: 1),
                                    () => LoginScreen(),
                                  );
                                } on AuthException catch (e) {
                                  if (e.statusCode == '429') {
                                    Get.snackbar(
                                      "Signup Failed",
                                      "Slow down! Wait a minute before trying again.",
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: const Color.fromARGB(
                                        76,
                                        244,
                                        67,
                                        54,
                                      ),
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Signup Failed",
                                      e.toString(),
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: const Color.fromARGB(
                                        76,
                                        244,
                                        67,
                                        54,
                                      ),
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              },
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
