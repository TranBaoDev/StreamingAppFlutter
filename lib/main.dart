import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/login_screen.dart';
import 'package:flutter_streaming_app/screens/onboarding_screen.dart';
import 'package:flutter_streaming_app/screens/signup_screen.dart';
import 'package:flutter_streaming_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streaming App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName:(context) => const LoginScreen(),
        SignUpScreen.routeName:(context) => const SignUpScreen(),
      },
      home: const OnBoardingScreen(),
    );
  }
}
