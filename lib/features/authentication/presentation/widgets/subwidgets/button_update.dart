import 'package:flutter/material.dart';
class ButtonUpdate extends StatelessWidget{
  final String buttonContent ;
  final VoidCallback? onTap;
  final Color colorButton ;
  const ButtonUpdate({required this.buttonContent,required this.onTap,required this.colorButton});
@override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
        //Navigator.pushNamed(context, '/profileInfo');

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; //
            }
            return  colorButton;
          },
        ),
      ),
      child:  Text(
        buttonContent,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}