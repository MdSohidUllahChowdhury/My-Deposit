import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';
import 'package:my_deposit/utils/custom/widget/auth/custom_auth_bottom.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/auth/input_field.dart';
import 'package:my_deposit/utils/custom/widget/auth/vibrant_background.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    phone.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (email.text.isEmpty || password.text.isEmpty || phone.text.isEmpty) {
      Get.snackbar(
        "SingUp Failed",
        "All fields are required",
        backgroundColor: Colors.red.withOpacity(0.4),
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: email.text.trim(),
        password: password.text.trim(),
        data: {'phone': phone.text.trim()},
      );

      if (res.session == null) {
        Get.snackbar(
          "Check Your Email",
          "A verification link has been sent to your inbox.",
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      } else {
        await Supabase.instance.client.from('profiles').insert({
          'id': res.user!.id,
          'phone': phone.text.trim(),
        });
        Get.snackbar(
          "Success",
          "Account created successfully!",
          backgroundColor: Colors.green.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
      Get.offAll(() => const LoginScreen());

    } on AuthException catch (e) {
      Get.snackbar(
        "Signup Failed",
        e.message,
        backgroundColor: Colors.red.withOpacity(0.4),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Opps! error",
        "Something went wrong. Please try again.",
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
                        const SizedBox(height: 30),
                        InputField(
                          hint: "Number",
                          controllerName: phone,
                          inputKeyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          hint: "Email",
                          controllerName: email,
                          inputKeyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          hint: "Password",
                          controllerName: password,
                          passwordVisible: true,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomAuthBottom(
                              bottomName: "LOGIN",
                              onTap: () => Get.to(
                                transition: Transition.rightToLeft,
                                () => const LoginScreen(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : CustomAuthBottom(
                                    bottomName: "Confirm",
                                    onTap: _handleSignUp,
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
