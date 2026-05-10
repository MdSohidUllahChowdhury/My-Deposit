import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void showExitDialog(BuildContext context) {
  Get.defaultDialog(
    title: "Exit App".toUpperCase(),
    middleText: "Are you sure you want to exit?",
    backgroundColor: const Color(0xFF1A1A1A),
    titleStyle: const TextStyle(color: Colors.white),
    middleTextStyle: const TextStyle(color: Colors.white70),
    textConfirm: "Confirm",
    textCancel: "Cancel",
    confirmTextColor: Colors.black,
    buttonColor: Colors.cyanAccent,
    onConfirm: () async {
      await SystemNavigator.pop();
    },
  );
}
