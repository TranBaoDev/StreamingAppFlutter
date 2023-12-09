import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button
        return false;
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
