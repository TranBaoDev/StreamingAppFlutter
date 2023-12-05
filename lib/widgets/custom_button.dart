import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

//CustomLoginBtn
class CustomButton extends StatelessWidget {
const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 19),
        backgroundColor: backgroundColor,
        minimumSize: const Size(352, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

//Other Custom Button Login

class CustomOtherButton extends StatelessWidget {
  const CustomOtherButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.imagePath,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final VoidCallback onTap;
  final String imagePath;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.maxFinite, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 50,
          ),
          Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
