import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Uint8List imageUrl;
  final String title;
  final String description;
  final VoidCallback onPressedCallback;

  const CardItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPressedCallback,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child:Container(
                width: double.infinity,
                height: 150.0,
                child: Image.memory(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),

                 // const SizedBox(height: 16.0),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 10),
              child: ElevatedButton(
                onPressed: onPressedCallback,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7FB77E)),
                ),
                child: const Text('Détailles',style: TextStyle(color: Colors.white),),
              ),
            ),


          ],
        ),
      ),
    );
  }
}