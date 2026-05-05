import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deposit/screen/auth/sing_up_screen.dart';
import 'package:my_deposit/screen/deposit/deposit_main.dart';
import 'package:my_deposit/utils/custom/widget/auth/custom_auth_bottom.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/auth/input_field.dart';
import 'package:my_deposit/utils/custom/widget/auth/vibrant_background.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                        //const SizedBox(height: 30),
                        Text(
                          "\nPlease login to your account\n",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 16,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        input_field(
                          hint: "Email",
                          controllerName: email,
                          giveKey: emailKey,
                        ),
                        const SizedBox(height: 16),
                        input_field(
                          hint: "Password",
                          controllerName: password,
                          giveKey: passwordKey,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_auth_bottom(
                              bottomName: "LOGIN",
                              onTap: () async {
                                if (email.text.isEmpty ||
                                    password.text.isEmpty) {
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
                                }
                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );
                                try {
                                  await Supabase.instance.client.auth
                                      .signInWithPassword(
                                        email: email.text,
                                        password: password.text,
                                      );
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                  );
                                  Get.offAll(() => const DepositMain());
                                  Get.snackbar(
                                    "Login Success",
                                    "Welcome back!",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: const Color.fromARGB(
                                      76,
                                      76,
                                      175,
                                      79,
                                    ),
                                    colorText: Colors.white,
                                  );
                                } catch (e) {
                                  Get.snackbar(
                                    "Login Failed",
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

                                return;
                              },
                            ),
                            const SizedBox(width: 16),

                            custom_auth_bottom(
                              bottomName: "Sing UP",
                              onTap: () {
                                Get.to(
                                  transition: Transition.leftToRight,
                                  duration: const Duration(seconds: 1),
                                  () => SingUpScreen(),
                                );
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
