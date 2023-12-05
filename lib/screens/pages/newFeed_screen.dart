import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/utils/colors.dart';

class NewfeedScreen extends StatefulWidget {
  const NewfeedScreen({super.key});

  @override
  State<NewfeedScreen> createState() => _NewfeedScreenState();
}

class _NewfeedScreenState extends State<NewfeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundIndex,
      body: Center(
        child: Text(
          'FEED SCREEN',
          style: TextStyle(color: textBtnColor),
        ),
      ),
    );
  }
}
