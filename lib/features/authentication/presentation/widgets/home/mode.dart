import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Mode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              buildPage('assets/screen4.svg', size),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login') ;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(300, 55)),
                    ),
                    child: const Text(
                      'Responsable',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/services') ;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(300, 55)),
                    ),
                    child: const Text(
                      'Utilisateur',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath, Size size) {
    return Container(
      child: SvgPicture.asset(
        imagePath,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}