import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SecondFormCovoiturage extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final Uint8List photo;

  SecondFormCovoiturage({
    required this.title,
    required this.description,
    required this.date,
    required this.photo,
  });

  static Widget fromRoute(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SecondFormCovoiturage(
      title: args['title']!,
      date: args['date']!,
      description: args['description']!,
      photo: args['photo']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final imageHeight = (screenHeight - topPadding) / 3;
    final containerHeight = screenHeight / 2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.memory(
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: containerHeight,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      color: Color(0xffF1F1F1),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Color(0xff414141),
                          ),
                        ),
                        const SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.timer_outlined,
                              color: Color(0xff414141),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date)),
                              style: GoogleFonts.abel(
                                height: 2.0,
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              description,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.abel(
                                height: 2.0,
                                fontSize: 17,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}