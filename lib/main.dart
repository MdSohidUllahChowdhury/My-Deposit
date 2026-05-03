import 'package:flutter/material.dart';
import 'package:my_deposit/screen/auth/login_screen.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    title: 'Glassmorphism Login',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ),
);
