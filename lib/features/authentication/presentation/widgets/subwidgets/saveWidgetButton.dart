import 'package:flutter/material.dart';

class SaveWidgetButon extends StatelessWidget {
  final String buttonContent;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? height;

  const SaveWidgetButon({
    super.key,
    required this.buttonContent,
    required this.onTap,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: height ?? 45,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          elevation: 2.0,
          backgroundColor: const Color(0xFF7FB77E),
        ),
        child: Text(
          buttonContent.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}