import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../core/functions/functions.dart';

class CarouselSliderAnnonce extends StatelessWidget {
  final List<Actualite> actualites;

  CarouselSliderAnnonce({Key? key, required this.actualites}) : super(key: key);

  List<Widget> cardList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < actualites.length; i++) {
      //print('This is photo ${actualites[i].photo!}') ;
      cardList.add(ImageActualite(titre: actualites[i].titre, description: actualites[i].description, image:  GetIt.I.get<Functions>().decodeBase64String(actualites[i].photo!,),
        onPressedCallback: () {
          Navigator.pushNamed(context, '/postWidget', arguments: {
            'photo':GetIt.I.get<Functions>().decodeBase64String(actualites[i].photo!),
            'title': actualites[i].titre,
            'date': actualites[i].date,
            'description': actualites[i].description,
          });
      },));
    }
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 2000),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              // Add any necessary logic here
            },
          ),
          items: cardList.map((card) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      //color: const Color(0xffFFFFFF),
                      child: card,
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ImageActualite extends StatelessWidget {
  final String titre;
  final String description;
  final Uint8List image;
  final VoidCallback onPressedCallback;


  const ImageActualite({Key? key, required this.titre, required this.description, required this.image,required this.onPressedCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressedCallback ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              width: double.infinity,
              height: 120.0,
              child: Image.memory(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: const TextStyle(
                    fontSize: 18.0,
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
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}