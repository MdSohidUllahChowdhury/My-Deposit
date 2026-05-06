import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Logout {
  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();

      Get.snackbar(
        "Logout Success",
        "You have been successfully logged out!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: Colors.white,
        icon: const Icon(Icons.logout, color: Colors.white),
        margin: const EdgeInsets.all(15),
        borderRadius: 10,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => LoginScreen());
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Logout failed: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
