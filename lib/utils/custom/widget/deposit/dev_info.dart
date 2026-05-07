// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // লিঙ্ক ওপেন করার জন্য

void showDeveloperInfo() {
  Get.snackbar(
    "",
    "",
    titleText: const Text(
      "Developer Information",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Built with ❤️ by Md. Sohid Ullah Chowdhury",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 15),

        // Social Links Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // LinkedIn
            _buildSocialIcon(
              icon: Iconsax.link_1_copy,
              color: Colors.blueAccent,
              onTap: () => _launchURL(
                "https://www.linkedin.com/in/md-sohid-ullah-chowdhury/",
              ),
            ),
            const SizedBox(width: 15),

            // GitHub
            _buildSocialIcon(
              icon: Iconsax.code_copy,
              color: Colors.white,
              onTap: () =>
                  _launchURL("https://github.com/MdSohidUllahChowdhury"),
            ),
            const SizedBox(width: 15),

            // Portfolio/Web
            _buildSocialIcon(
              icon: Iconsax.global_copy,
              color: Colors.orangeAccent,
              onTap: () =>
                  _launchURL("https://sohidullahchowdhury.netlify.app/"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.white24),
        const Text(
          "A small amount of Halal wealth brings more peace than a mountain of Haram.",
          style: TextStyle(
            color: Colors.amberAccent,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black.withOpacity(.87),
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(20),
    duration: const Duration(seconds: 25),
    isDismissible: true,
    overlayBlur: 2,
    barBlur: 20,
    borderWidth: 1,
    borderColor: Colors.white10,
  );
}

Widget _buildSocialIcon({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 22),
    ),
  );
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    Get.snackbar("Error", "Could not launch $url", colorText: Colors.white);
  }
}
