import 'package:flutter/material.dart';

class DismissKeyboardOnTap extends StatelessWidget {
  final Widget child;

  DismissKeyboardOnTap({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside of text fields
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
