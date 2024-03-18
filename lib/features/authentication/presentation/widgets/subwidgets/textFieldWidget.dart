import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final controller;
  final borderStyle ;
  final bool isTextObscure;
  final String? placeholder;
  final Icon? iconPrefix;
  final Color colorInputField;
  final TextInputType?  keyboardtype ;
  final OutlineInputBorder? borderInput ;
  final TextStyle? textStyle ;
  const TextFieldWidget(
      {super.key,
        this.textStyle,
          this.borderStyle,
          this.borderInput,
          this.keyboardtype,
          this.validator,
          this.placeholder,
          this.iconPrefix,
        required this.controller,
        required this.isTextObscure,
        required this.colorInputField
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: 78,
      child: TextFormField(
        style: textStyle,
        keyboardType: keyboardtype,
        controller: controller,
        obscureText: isTextObscure,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: borderStyle,
          border: borderInput,
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
