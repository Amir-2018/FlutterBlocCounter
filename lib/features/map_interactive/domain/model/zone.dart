import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:latlong2/latlong.dart';

class Zone {
  final int? id;
  final String nom;
  final List<Establishment> establishment;
  final List<LatLng> borders;
  final String surface;
  final List<Lot> lots;
  final LatLng positionMarqueur;

  const Zone({
    this.id,
    required this.nom,
    required this.establishment,
    required this.borders,
    required this.surface,
    required this.lots,
    required this.positionMarqueur,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      nom: json['nom'],
      establishment: (json['establishment'] as List<dynamic>)
          .map((est) => Establishment.fromJson(est))
          .toList(),
      borders: (json['borders'] as List<dynamic>)
          .map((border) => LatLng(border.latitude, border.longitude))
          .toList(),
      surface: json['surface'],
      lots: (json['lots'] as List<dynamic>)
          .map((lot) => Lot.fromJson(lot))
          .toList(),
      positionMarqueur: LatLng(json['positionMarqueur'][0], json['positionMarqueur'][1]),
    );
  }

  factory Zone.fromMap(Map<String, dynamic> map) {
    return Zone(
      id: map['id'],
      nom: map['nom'],
      establishment: map['establishment'],
      borders: (map['borders'] as List<dynamic>)
          .map((border) => LatLng(border['latitude'], border['longitude']))
          .toList(),
      surface: map['surface'],
      //lot: Lot.fromMap(map['lot']),
      lots: (map['lots'] as List<dynamic>)
          .map((lot) => Lot.fromMap(lot))
          .toList(),
      positionMarqueur: LatLng(map['positionMarqueur']['latitude'], map['positionMarqueur']['longitude']),
    );
  }
}