import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundIndex,
      body: Center(
        child: Text(
          'NOTIFICATION SCREEN',
          style: TextStyle(color: textBtnColor),
        ),
      ),
    );
  }
}
