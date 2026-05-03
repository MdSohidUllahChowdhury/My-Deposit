import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';

void main() => runApp(
  GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ),
);
