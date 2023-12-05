import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundIndex,
      body: Center(
        child: Text(
          'PROFILE SCREEN',
          style: TextStyle(color: textBtnColor),
        ),
      ),
    );
  }
}