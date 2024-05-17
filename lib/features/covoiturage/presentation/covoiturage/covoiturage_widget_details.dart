import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CovoituragesWidgetDetails extends StatelessWidget {
  final String depart;
  final String destination;
  final String description;
  final String photo;
  final String titre;
  final String nb_personnes;
  final String temps_depart;
  final String date;
  final String contact;
  final String type;
  final String cotisation;

  CovoituragesWidgetDetails({
    required this.titre,
    required this.depart,
    required this.destination,
    required this.description,
    required this.date,
    required this.photo,
    required this.nb_personnes,
    required this.temps_depart,
    required this.contact,
    required this.cotisation,
    required this.type,
  });

  static Widget fromRoute(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print('Tile is yesss ${args['titre']}');

    return CovoituragesWidgetDetails(
      titre: args['titre']!,
      depart: args['depart']!,
      destination: args['destination']!,
      description: args['description']!,
      date: args['date']!,
      photo: '',
      nb_personnes: (args['nb_personnes']!).toString(),
      temps_depart: args['temps_depart']!,
      contact: args['contact']!,
      cotisation: (args['cotisation']!).toString(),
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
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/covoiturages/covoiturage.png',
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
                        const SizedBox(height: 12),
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date)),
                          style: GoogleFonts.abel(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: const Color(0xff333333),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                depart,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.abel(
                                  height: 2.0,
                                  fontSize: 17,
                                  color: const Color(0xff333333),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_off_outlined,
                              color: const Color(0xff333333),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                destination,
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
                        const SizedBox(height: 12),


                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  const SizedBox(width: 15.0,) ,


                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Départ',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        temps_depart,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 15.0,) ,

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        'Prix',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        cotisation,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        'Contact',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        contact,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nombre',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        nb_personnes,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),                                Column(
                                    children: [
                                      Text(
                                        'Contact',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        contact,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.abel(
                                          height: 2.0,
                                          fontSize: 17,
                                          color: const Color(0xff414141),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              description,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.abel(
                                height: 2.0,
                                fontSize: 17,
                                color: const Color(0xff333333),
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