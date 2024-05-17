import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VenteWidgetDetails extends StatelessWidget {
  final String objet;
  final String prix;
  final String quantite;
  final String titre;
  final Uint8List photo;
  final String description;
  final String date;
  final String contact;
  final String type;

  VenteWidgetDetails({
    required this.objet,
    required this.prix,
    required this.quantite,
    required this.titre,
    required this.photo,
    required this.description,
    required this.date,
    required this.contact,
    required this.type,
  });

  static Widget fromRoute(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print('Tile is yesss ${args['titre']}');

    return VenteWidgetDetails(
      objet: args['objet']!,
      prix: (args['prix']!).toString(),
      quantite: (args['quantite']!).toString(),
      titre: args['titre']!,
      photo: args['photo']!,
      description: (args['description']!).toString(),
      date: args['date']!,
      contact: args['contact']!,
      type: args['type']!,
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
                          titre,
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Color(0xff414141),
                          ),
                        ),
                        const SizedBox(height: 15),

                        Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date)),
                          style: GoogleFonts.abel(
                            height: 2.0,
                            fontSize: 14,
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),

                        Text(
                          objet,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.abel(
                            height: 2.0,
                            fontSize: 17,
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [

                            Expanded(
                              flex: 0,
                              child: Text(
                                quantite,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.abel(
                                  height: 2.0,
                                  fontSize: 17,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            Text(
                              'piéces',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.abel(
                                height: 2.0,
                                fontSize: 17,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [

                            Expanded(
                              flex: 0,
                              child: Text(
                                prix,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.abel(
                                  height: 2.0,
                                  fontSize: 17,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),

                            Text(
                              'DT',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.abel(
                                height: 2.0,
                                fontSize: 17,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: Color(0xff414141),
                            ),
                            const SizedBox(width: 27),
                            Expanded(
                              child: Text(
                                contact,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.abel(
                                  height: 2.0,
                                  fontSize: 17,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),

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
                            ),
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