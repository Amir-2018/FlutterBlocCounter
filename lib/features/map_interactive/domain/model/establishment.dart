import 'dart:async';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';

import 'lot.dart';
import 'package:latlong2/latlong.dart';

class Establishment {
  final int? id;
  final String nom;
  final String type;
  final String tel;
  final String fax;
  final String contact;
  final String surface;
  final List<Lot> lots;
  final LatLng position;


  const Establishment({
    this.id,
    required this.nom,
    required this.type,
    required this.tel,
    required this.fax,
    required this.contact,
    required this.surface,
    required this.lots,
    required this.position,

  });

  factory Establishment.fromJson(Map<String, dynamic> json) {
    return Establishment(
      id: json['id'],
      nom: json['nom'],
      type: json['type'],
      tel: json['tel'],
      fax: json['fax'],
      contact: json['contact'],
      surface: json['surface'],
      lots: (json['lots'] as List<dynamic>)
          .map((lot) => Lot.fromJson(lot))
          .toList(),
      position: LatLng(json['position'][0], json['position'][1]),
    );
  }

  factory Establishment.fromMap(Map<dynamic, dynamic> map) {
    return Establishment(
      id: map['id'],
      nom: map['nom'],
      type: map['type'],
      tel: map['tel'],
      fax: map['fax'],
      contact: map['contact'],
      surface: map['surface'],
      lots: map['lots'],
      position : map['position'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'type': type,
      'tel': tel,
      'fax': fax,
      'contact': contact,
      'surface': surface,
      'lots': lots,
      'position' : position,
    };
  }
}