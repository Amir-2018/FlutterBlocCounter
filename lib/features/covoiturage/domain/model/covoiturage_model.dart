import '../../../annonces/domain/model/actualite.dart';

class CovoiturageModel extends Actualite {
  final String depart;
  final String destination;
  final String temps_depart;
  final int nb_personnes;
  final double cotisation;

  const CovoiturageModel({
    int? id,
    required this.depart,
    required this.destination,
    required this.temps_depart,
    required this.cotisation,
    required this.nb_personnes,
    required String titre,
    required String? photo,
    required String description,
    required String? date,
    required String contact,
    required String type,
    required int confirmed,

  }) : super(
    id: id,
    titre: titre,
    photo: photo,
    description: description,
    date: date,
    contact: contact,
    type: type,
    confirmed: confirmed,

  );

  factory CovoiturageModel.fromJson(Map<String, dynamic> json) {

    return CovoiturageModel(
      depart: json['depart'],
      destination: json['destination'],
      description: json['description'],
      photo: json['photo'],
      titre: json['titre'],
      nb_personnes: json['nb_personnes'],
      temps_depart: json['temps_depart'],
      date: json['date'],
      contact: json['contact'],
      type: json['type'],
      cotisation: json['cotisation'],
      confirmed: json['confirmed'] == true ? 1 : 0,
    );
  }

  factory CovoiturageModel.fromMap(Map<dynamic, dynamic> map) {
    return CovoiturageModel(
      depart: map['depart'],
      destination: map['destination'],
      description: map['description'],
      photo: map['photo'],
      titre: map['titre'],
      nb_personnes: map['nb_personnes'],
      temps_depart: map['temps_depart'],
      date: map['date'],
      contact: map['contact'],
      type: map['type'],
      cotisation: map['cotisation'],
      confirmed: map['confirmed'] == true ? 1 : 0,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'depart': getId,
      'destination': destination,
      'description': description,
      'photo': photo,
      'titre': titre,
      'nb_personnes': nb_personnes,
      'temps_depart': temps_depart,
      'contact': contact,
      'date': date,
      'cotisation': cotisation,
      'type': type,
      'confirmed' : confirmed,

    };
  }

}