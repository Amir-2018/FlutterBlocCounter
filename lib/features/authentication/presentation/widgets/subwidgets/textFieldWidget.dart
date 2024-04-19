import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final controller;
  final borderStyle;
  final bool isTextObscure;
  final String? placeholder;
  final Icon? iconPrefix;
  final Color colorInputField;
  final TextInputType? keyboardtype;
  final OutlineInputBorder? borderInput;
  final TextStyle? textStyle;
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
      required this.colorInputField});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: 78,
      child: TextFormField(
        style: const TextStyle(
          // Adding more style to the text
          fontSize: 16,
          color: Color(0xFF414141),
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.emailAddress,
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
            // Adjusting hint text style
            fontSize: 14,
            color: Color(0xFF414141),
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: iconPrefix != null
              ? Container(
                  // Check if iconPrefix is not null
                  padding: EdgeInsets.all(12), // Adjust padding as needed
                  child: Icon(
                    // Use Icon widget directly for customization
                    iconPrefix!.icon,
                    color: Color(0xff7FB77E), // Set the desired color for the prefix icon
                  ),
                )
              : null, // If iconPrefix is null, set prefixIcon to null

          contentPadding: const EdgeInsets.symmetric(
              vertical: 16, horizontal: 16), // Adding padding around the text
          focusedBorder: OutlineInputBorder(
            // Customizing border when focused
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.black38, // Change the border color when focused
              width: 2, // Change the border width when focused
            ),
          ),
          errorBorder: OutlineInputBorder(
            // Customizing border when there's an error
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color:
                  Colors.red, // Change the border color when there's an error
              width: 2, // Change the border width when there's an error
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Customizing border when focused and there's an error
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors
                  .red, // Change the border color when focused and there's an error
              width:
                  2, // Change the border width when focused and there's an error
            ),
          ),
          errorStyle: const TextStyle(
            // Adjusting error text style
            fontSize: 12,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
