import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/login_screen.dart';
import 'package:flutter_streaming_app/screens/signup_screen.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = '/onBoarding';
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            left: 15,
            top: 10,
            child: SafeArea(
              child: Text(
                'RubberDuck',
                style: GoogleFonts.sora(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -20,
            top: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: SizedBox.fromSize(
                child: Image.asset(
                  'assets/img/first-screen-duck.jpg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ).copyWith(
              top: 10,
              bottom: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's\nget started",
                  style: GoogleFonts.sora(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 48,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Everything start from here',
                  style: GoogleFonts.sora(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    text: "Log in",
                    backgroundColor: buttonColor,
                    textColor: textBtnColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  text: "Sign up",
                  backgroundColor: buttonColor,
                  textColor: textBtnColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
