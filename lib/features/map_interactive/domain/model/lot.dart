import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';

class Lot {
  final bool etat;
  final Establishment establishment;

  const Lot({
    required this.etat,
    required this.establishment,
  });

  factory Lot.fromJson(Map<String, dynamic> json) {
    return Lot(
      etat: json['etat'],
      establishment: Establishment.fromJson(json['establishment']),
    );
  }

  factory Lot.fromMap(Map<String, dynamic> map) {
    return Lot(
      etat: map['etat'],
      establishment: Establishment.fromMap(map['establishment']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'etat': etat,
      'establishment': establishment.toMap(),
    };
  }
}