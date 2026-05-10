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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        "Login Declined",
        "Email and Password are required!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.4),
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      Get.snackbar(
        "Login Success",
        "Welcome back!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.5),
        colorText: Colors.white,
      );

      Get.offAll(() => const DepositMain(), transition: Transition.leftToRight);
    } on AuthException catch (e) {
      Get.snackbar(
        "Login Failed",
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.4),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong, please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.4),
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

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
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/asset/logo.png'),
                  ),
                  const SizedBox(height: 30),
                  GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "My Deposit",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Track your finances with style and clarity",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Please login to your account",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        input_field(hint: "Email", controllerName: email),
                        const SizedBox(height: 16),
                        input_field(hint: "Password", controllerName: password),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : custom_auth_bottom(
                                    bottomName: "LOGIN",
                                    onTap: _handleLogin,
                                  ),
                            const SizedBox(width: 16),
                            custom_auth_bottom(
                              bottomName: "SIGN UP",
                              onTap: () => Get.to(
                                () => const SingUpScreen(),
                                transition: Transition.leftToRight,
                              ),
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
