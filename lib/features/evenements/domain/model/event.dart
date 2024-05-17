import 'package:pfechotranasmartvillage/features/authentication/domain/model/user.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';

class Evenement {
  final int? id;
  final String type;
  final String? titre;
  final String description;
  final String category;
  final PointLocation position;
final String date_debut;
  final String localisation;

  final String date_fin;
  final String limite;
  final String photo;
  final String lienInscription;
  final String organisateur ;



  const Evenement( {
    this.id,
    required this.type,
    required this.titre,
    required this.description,
    required this.position,
    required this.date_debut,
    required this.date_fin,
    required this.limite,
    required this.photo,
    required this.category,
    required this.localisation,
    required this.organisateur,
    required this.lienInscription,









  });
  factory Evenement.fromJson(Map<String, dynamic> json) {
    print(getIt<Functions>().stringToPointLocation(json['position'])) ;
    return Evenement(
      id: json['id'],
      type: json['type'],
      titre: json['titre'],
      description: json['description'],
      position: PointLocation.fromMap(json['position']),
      date_debut: json['dateDebut'],
      date_fin: json['dateFin'],
      limite: json['limite'],
      photo: json['photo'],
      category: json['category'],
      localisation: json['localisation'],
      organisateur: json['organisateur'],
      lienInscription: json['lienInscription'],




    );
  }


  factory Evenement.fromMap(Map<dynamic, dynamic> map) {
    return Evenement(
      type: map['type'],
      titre: map['titre'],
      description: map['description'],
      position: map['position'],
      date_debut: map['date_debut'],
      date_fin: map['date_fin'],
      limite: map['limite'],
      photo: map['photo'],
      localisation: map['localisation'],
      organisateur: map['organisateur'],
      lienInscription: map['lienInscription'],

      category: '',




    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'type': type,
      'description': description,
      'position': position,
      'date_debut': date_debut,
      'date_fin' : date_fin,
      'limite': limite,
      'photo': photo,
      'category': category,
      'localisation': localisation,
      'organisateur': organisateur,
      'lienInscription': lienInscription,



    };
  }

}

