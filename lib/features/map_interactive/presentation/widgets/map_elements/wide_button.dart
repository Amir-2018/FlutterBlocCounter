import 'package:flutter/material.dart';


class WideButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  WideButton({
    Key? key,
    required this.text,
    this.textStyle,
    this.height,
    this.width,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue, // Utilisation d'une couleur par défaut si backgroundColor est nul
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}