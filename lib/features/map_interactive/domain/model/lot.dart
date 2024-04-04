import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:latlong2/latlong.dart';

class Lot {
  final String etat;
  final Establishment etablissement;
  final List<List<LatLng>> positions;
  final String surface;
  final double prixCarre;

  const Lot({
    required this.etat,
    required this.etablissement,
    required this.positions,
    required this.surface,
    required this.prixCarre,
  });

  factory Lot.fromJson(Map<String, dynamic> json) {
    return Lot(
      etat: json['etat'],
      etablissement: Establishment.fromJson(json['etablissement']),
      positions: (json['positions'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => LatLng(e[0], e[1])).toList()).toList(),
      surface: json['surface'],
      prixCarre: json['prixCarre'].toDouble(),
    );
  }

  factory Lot.fromMap(Map<String, dynamic> map) {
    return Lot(
      etat: map['etat'],
      etablissement: Establishment.fromMap(map['etablissement']),
      positions: (map['positions'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => LatLng(e[0], e[1])).toList()).toList(),
      surface: map['surface'],
      prixCarre: map['prixCarre'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'etat': etat,
      'etablissement': etablissement.toMap(),
      'positions': positions.map((e) => e.map((e) => [e.latitude, e.longitude]).toList()).toList(),
      'surface': surface,
      'prixCarre': prixCarre,
    };
  }
}