import 'package:flutter/material.dart';

String? errorText(TextEditingController controller) {
  // at any time, we can get the text from _controller.value.text
  final text = controller.value.text;
  // Note: you can do your own custom validation here
  // Move this logic this outside the widget for more testable code
  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  if (text.length < 4) {
    return 'Too short';
  }
  // return null if the text is valid
  return null;
}
