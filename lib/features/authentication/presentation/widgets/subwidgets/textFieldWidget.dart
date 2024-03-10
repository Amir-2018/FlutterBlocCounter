import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final controller;
  final bool isTextObscure;
  final String placeholder;
  final Icon iconPrefix;
  final Color colorInputField;

  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.isTextObscure,
      required this.validator,
      required this.placeholder,
      required this.iconPrefix,
      required this.colorInputField});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: 39,
      child: TextFormField(
        controller: controller,
        obscureText: isTextObscure,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color(0xFF4913130F), width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: colorInputField,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFF414141),
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: iconPrefix,
        ),
      ),
    );
  }
}
