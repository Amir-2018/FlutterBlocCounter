import 'dart:async';

import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';

class Lot {
  final int numero ;
  final bool etat;
  final List<PointLocation> bordures ;
  final Establishment establishment;
  final Zone zone;


  const Lot({
    required this.numero,
    required this.etat,
    required this.bordures,
    required this.establishment,
    required this.zone,
  });

  factory Lot.fromJson(Map<String, dynamic> json) {
    return Lot(
      numero: json['numero'],
      etat: json['etat'],
      establishment: Establishment.fromJson(json['etablissement']),
      zone: Zone.fromJson(json['zone']),
      bordures: (json['bordures'] as List<dynamic>)
          .map((bordureJson) => PointLocation.fromJson(bordureJson))
          .toList(),
    );
  }

  factory Lot.fromMap(Map<String, dynamic> map) {
    return Lot(
      numero: map['numero'],
      etat: map['etat'],
      bordures: map['bordures'] ,
      establishment: Establishment.fromMap(map['establishment']),
      zone: Zone.fromMap(map['zone']),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'etat': etat,
      'establishment': establishment.toMap(),
      'bordures': bordures.map((bordure) => bordure.toMap()).toList(),
    };
  }
  factory Lot.empty() {
    return const Lot(
      numero: 0,
      etat : false,
      bordures: [],
      establishment: Establishment(
        id: null,
        nom: "",
        lots: [],
        telephone: "",
        fax: "",
        contacts: [],
        categorie: "",
        surface: "",
        lien: "",
        position: PointLocation(lat: 0, lng: 0),
      ),
        zone: Zone(
      id: null,
      nom: "",
      bordures: [],
      nombre_lots: 0,
    )
      /*  lots: [],*/
    );
  }

}

