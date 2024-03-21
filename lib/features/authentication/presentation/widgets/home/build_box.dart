import 'package:flutter/material.dart';

Widget buildBox({required Color color,required IconData icon,required String title}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0), // Add rounded corners with 10px radius
    ),
    width: 150.0,
    height: 200.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // Center content vertically
      children: [
         Icon(icon,size: 80,color: Colors.white,),
        Text(title.toString(),style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF)
        ),),
        SizedBox(height: 10.0), // Add spacing between icon and title
      ],
    ),
  );
}