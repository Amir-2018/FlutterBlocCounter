import 'package:flutter/material.dart';

import '../subwidgets/button_navigation_bar.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<String> _imageUrls = [
    "assets/car.jpg",
    "assets/chotrana.png",
    "assets/news.jpg",
  ];

  List<Map<String, dynamic>> _services = [
    {
      "icon": Icons.map_outlined,
      "title": "Map",
    },
    {"icon": Icons.newspaper_outlined, "title": "Actualités"},
    {"icon": Icons.local_convenience_store_rounded, "title": "Conventions"},
    {"icon": Icons.directions_car, "title": "covoiturage"},
    {"icon": Icons.report_outlined, "title": "Réclamations"},
    {"icon": Icons.event, "title": "Evenements"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: _imageUrls.map((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0, // Espacement depuis le haut
                              bottom: 0.0, // Espacement depuis le bas
                              left: 10.0, // Espacement depuis la gauche
                              right: 10.0, // Espacement depuis la droite
                            ),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildIndicators(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 3, // Changed from 2 to 3
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _services
                      .map((service) => _buildServiceBox(service))
                      .toList(),
                ),
              ],
            ),
            flex: 10,
          ),
          Expanded(
            child: const ButtonNavigationBar(),
            flex: 1,
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < _imageUrls.length; i++) {
      indicators.add(_indicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildServiceBox(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            service["icon"],
            size: 40,
            color: Color(0xff3960CA),
          ),
          SizedBox(height: 10),
          Text(
            service["title"],
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
