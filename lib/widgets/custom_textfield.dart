import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const CustomTextField({
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
            color: backgroundContain,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: outlineColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(15),
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

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTap;
  const ChatTextField({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onTap,
      cursorHeight: 20,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: backgroundContain,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: outlineColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        hintStyle: GoogleFonts.sora(
          color: secondTextColor,
          fontSize: 18,
        ),
        fillColor: fillTextColor,
      ),
    );
  }
}
