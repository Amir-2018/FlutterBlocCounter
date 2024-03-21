import 'package:flutter/material.dart';

class SaveWidgetButon extends StatelessWidget {
  final String buttonContent;
  final VoidCallback? onTap;
  const SaveWidgetButon(
      {super.key, required this.buttonContent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: 45,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 2.0,
              backgroundColor: const Color(0xFF1F7774)),
          child: Text(
            buttonContent.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
