import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: backgroundColor,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: GoogleFonts.sora(
          color: secondTextColor,
          fontSize: 18,
        ),
        fillColor: fillTextColor,
      ),
    );
  }
}
