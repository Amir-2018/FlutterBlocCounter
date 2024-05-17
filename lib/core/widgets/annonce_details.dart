import 'package:flutter/material.dart';

import '../../features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';

class AnnonceDetailsWidget extends StatelessWidget {
  final String title;
  final String content;

  AnnonceDetailsWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),

          ],
        ),
      ),
    );
  }
}