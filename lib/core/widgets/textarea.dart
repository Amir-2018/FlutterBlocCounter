import 'package:flutter/material.dart';

class Textarea extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final InputBorder borderStyle;
  final String? placeholder;
  final Color colorInputField;
  final TextInputType? keyboardType;
  final OutlineInputBorder? borderInput;
  final TextStyle? textStyle;
  final double widthTextarea ;

  const Textarea(

      {
    Key? key,
        required this.widthTextarea,
        required this.validator,
    required this.controller,
    required this.borderStyle,
    required this.placeholder,
    required this.colorInputField,
    this.keyboardType,
    this.borderInput,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthTextarea,
      child: TextFormField(
        maxLines: 5,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: borderInput ?? borderStyle,
          hintText: placeholder,
          filled: true,
          fillColor: colorInputField,
        ),
        keyboardType: keyboardType,
        style: textStyle,
      ),
    );
  }
}