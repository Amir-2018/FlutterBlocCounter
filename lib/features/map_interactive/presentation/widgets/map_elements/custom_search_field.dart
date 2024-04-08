import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;

  CustomSearchField({
    required this.controller,
    required this.focusNode,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF8E8E93)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search, color: Color(0xFF8E8E93)),
        contentPadding: EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (String value) {
        // Votre logique onChanged ici
      },
    );
  }
}