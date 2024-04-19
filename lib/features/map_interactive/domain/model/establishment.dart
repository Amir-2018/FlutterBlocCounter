import 'dart:async';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

import 'lot.dart';
import 'contact.dart'; // Ajout de l'import manquant
import 'package:latlong2/latlong.dart';

class Establishment {
  final int? id;
  final String nom;
  final List<Lot> lots;
  final String telephone;
  final String fax;
  //final List<Contact> contacts;
  final String categorie;
  final String etablissementEnum;
  final double surface;
  final String lien;
  final PointLocation position;

  const Establishment({
    this.id,
    required this.nom,
    required this.lots,
    required this.telephone,
    required this.fax,
    //required this.contacts,
    required this.categorie,
    required this.etablissementEnum,
    required this.surface,
    required this.lien,
    required this.position,
  });

  factory Establishment.fromJson(Map<String, dynamic> json) {
    return Establishment(
      id: json['id'],
      nom: json['nom'],
      telephone: json['telephone'],
      fax: json['fax'],
      /*contacts: (json['contacts'] as List<dynamic>)
          .map((contact) => Contact.fromJson(contact))
          .toList(),*/
      etablissementEnum: json['etablissementEnum'],
      surface: json['surface'].toDouble(),
      lien: json['lien'],
      position: PointLocation(
        lat: json['position']['lat'],
        lng: json['position']['lng'],
      ),
      lots: (json['lots'] as List<dynamic>)
          .map((lot) => Lot.fromJson(lot))
          .toList(),
      categorie: json['categorie'],
    );
  }

  factory Establishment.fromMap(Map<String, dynamic> map) {
    return Establishment(
      id: map['id'],
      nom: map['nom'],
      telephone: map['telephone'],
      fax: map['fax'],
     /* contacts: (map['contacts'] as List<dynamic>)
          .map((contact) => Contact.fromMap(contact))
          .toList(),*/
      etablissementEnum: map['etablissementEnum'],
      surface: map['surface'].toDouble(),
      lien: map['lien'],
      position: PointLocation(
        lat: map['position']['lat'],
        lng: map['position']['lng'],
      ),
      lots: (map['lots'] as List<dynamic>)
          .map((lot) => Lot.fromMap(lot))
          .toList(),
      categorie: map['categorie'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'telephone': telephone,
      'fax': fax,
      //'contacts': contacts.map((contact) => contact.toMap()).toList(),
      'etablissementEnum': etablissementEnum,
      'surface': surface,
      'lien': lien,
      'position': {
        'lat': position.lat,
        'lng': position.lng,
      },
      'lots': lots.map((lot) => lot.toMap()).toList(),
    };
  }
}

