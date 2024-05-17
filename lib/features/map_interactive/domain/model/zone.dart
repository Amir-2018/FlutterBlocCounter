import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';



class Zone {
  final int? id;
  final List<PointLocation> bordures;
  final String nom;
  final int nombre_lots;
  //final List<Lot>? lots;

  const Zone({
    this.id,
    required this.bordures,
    required this.nom,
    required this.nombre_lots,
   // this.lots,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      bordures: (json['bordures'] as List<dynamic>)
          .map((bordureJson) => PointLocation.fromJson(bordureJson))
          .toList(),
      nom: json['nom'],

      nombre_lots: json['nombre_lots'],

      /*lots: (json['lots'] as List<dynamic>)
          .map((lotJson) => Lot.fromJson(lotJson))
          .toList(),*/
    );
  }

  factory Zone.fromMap(Map<String, dynamic> map) {
    return Zone(
      id: map['id'] != null ? map['id'] : '',

      bordures: map['bordures'] ,
      nom: map['nom'] != null ? map['nom'] : '',
      /*etablissements: (map['etablissements'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map((etablissementMap) => Establishment.fromMap(etablissementMap))
          .toList(),*/
      nombre_lots: map['nombre_lots'] != null ? map['nombre_lots'] : 0,

      /*lots: (map['lots'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map((lotMap) => Lot.fromMap(lotMap))
          .toList(),*/
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bordures': bordures.map((bordure) => bordure.toMap()).toList(),
      'nom': nom,
      'nombre_lots': nombre_lots,
      /*'lots': lots?.map((lot) => lot.toMap()).toList(),*/
    };
  }

  factory Zone.empty() {
    return const Zone(
      id: null,
      bordures: [],
      nom: '',
      nombre_lots: 0,
    /*  lots: [],*/
    );
  }
}