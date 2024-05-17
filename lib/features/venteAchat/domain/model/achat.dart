import '../../../annonces/domain/model/actualite.dart';

class Achat extends Actualite {
  final double prix;
  final int quantite;
  final String contact;


  const Achat({
    required this.prix,
    required this.quantite,
    required this.contact,

    int? id,
    required String titre,
    required String? photo,
    required String description,
    required String? date,
    required String type,
    required int confirmed,


  }) : super(
    id: id,
    titre: titre,
    photo: photo,
    description: description,
    date: date,
    contact : contact,
      type : type,
      confirmed : confirmed


  );

  factory Achat.fromJson(Map<String, dynamic> json) {
    return Achat(
      prix: json['prix'],
      quantite: json['quantite'],
      id: json['id'],
      titre: json['titre'],
      photo: json['photo'],
      description: json['description'],
      date: json['date'],
      contact: json['contact'],
      type: json['type'],
      confirmed: json['confirmed'],



    );
  }

  factory Achat.fromMap(Map<dynamic, dynamic> map) {
    return Achat(
      prix: map['prix'],
      quantite: map['quantite'],
      titre: map['titre'],
      photo: map['photo'],
      description: map['description'],
      date: map['date'],
      contact: map['contact'],
      type: map['type'],
      confirmed: map['confirmed'],



    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': getId,
      'titre': getTitre,
      'photo': photo,
      'description': getDescription,
      'date': date,
      'contact': contact,
      'prix': prix,
      'quantite': quantite,
      'type': type,
      'confirmed': confirmed,


    };
  }

  // Getter for prix
  double get getPrix => prix;

  // Setter for prix
  Achat setPrix(double newPrix) {
    return Achat(
      prix: newPrix,
      quantite: this.quantite,
      id: this.getId,
      titre: this.getTitre,
      photo: this.photo,
      description: this.getDescription,
      date: date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,



    );
  }

  // Getter for quantite
  int get getQuantite => quantite;

  // Setter for quantite
  Achat setQuantite(int newQuantite) {
    return Achat(
      prix: this.prix,
      quantite: newQuantite,
      id: this.getId,
      titre: this.getTitre,
      photo: this.photo,
      description: this.getDescription,
      date: this.date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,



    );
  }
}