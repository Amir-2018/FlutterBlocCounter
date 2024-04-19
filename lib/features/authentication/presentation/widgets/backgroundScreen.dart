import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/screen1.svg',
    'assets/screen2.svg',
    'assets/screen3.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return buildPage(imagePaths[index]);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mode');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7FB77E)),
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 55)),
                ),
                child: Text(
                  'Commencer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath) {
    return Container(
      child: SvgPicture.asset(
        imagePath,
        width: 500,
        height: 500,
      ),
    );
  }
}