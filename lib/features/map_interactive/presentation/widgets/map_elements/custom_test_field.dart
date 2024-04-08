import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Color(0xFF1E1E1E),
        fontSize: 14,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: 'test',
        hintStyle: const TextStyle(
          color: Color(0xFF1E1E1E),
          fontSize: 14,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            //color: Color(0xFFFFEAEA),
          ),
          child: const Icon(
            Icons.add_location_alt_outlined,
            color: Color(0xFFC91C1C),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        fillColor: Color(0xFFF5F5F5),
        filled: true,
        isDense: true, // Add this line to make the padding smaller and more precise
      ),
    );
  }
}