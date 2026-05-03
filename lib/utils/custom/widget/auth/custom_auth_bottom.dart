import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class custom_auth_bottom extends StatelessWidget {
  final String bottomName;
  final void Function()? onTap;
  const custom_auth_bottom({super.key, this.bottomName = "LOGIN", this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
        color: bottomName == "LOGIN"
            ? const Color.fromRGBO(255, 255, 255, 0.2)
            : const Color.fromARGB(198, 149, 211, 3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.2)),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            // Handle login logic here
            onTap?.call();
          },
          child: Text(
            bottomName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
