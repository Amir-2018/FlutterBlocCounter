import '../../../annonces/domain/model/actualite.dart';

class Vente extends Actualite {
  final String objet;
  final double prix;
  final int quantite;
  final int annonceAchat;


  const Vente({
    required this.objet,
    required this.prix,
    required this.quantite,
    required this.annonceAchat,

    int? id,
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

  factory Vente.fromJson(Map<String, dynamic> json) {

    return Vente(
      objet: json['objet'],
      prix: json['prix'],
      quantite: json['quantite'],
      id: json['id'],
      titre: json['titre'],
      photo: json['photo'],
      description: json['description'],
      date: json['date'],
      contact: json['contact'],
      type: json['type'],
      confirmed: json['confirmed'] == true ? 1 : 0,
      annonceAchat: json['annonceAchat']== true ? 1 : 0,
    );
  }

  factory Vente.fromMap(Map<dynamic, dynamic> map) {
    return Vente(
      objet: map['objet'],
      prix: map['prix'],
      quantite: map['quantite'],
      titre: map['titre'],
      photo: map['photo'],
      description: map['description'],
      date: map['date'],
      contact: map['contact'],
      type: map['type'],
      confirmed: map['confirmed'],
      annonceAchat: map['annonceAchat'] == true ? 1 : 0,




    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': getId,
      'objet': objet,
      'titre': getTitre,
      'photo': photo,
      'description': getDescription,
      'date': date,
      'prix': prix,
      'quantite': quantite,
      'contact': contact,
      'type': type,
      'confirmed' : confirmed,
      'annonceAchat': annonceAchat,



    };
  }

  // Getter for prix
  double get getPrix => prix;

  // Setter for prix
  Vente setPrix(double newPrix) {
    return Vente(
      objet: this.objet,
      prix: newPrix,
      quantite: this.quantite,
      id: this.getId,
      titre: this.getTitre,
      photo: this.photo,
      description: this.getDescription,
      date: this.date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,
      annonceAchat: this.annonceAchat,




    );
  }

  // Getter for quantite
  int get getQuantite => quantite;

  // Setter for quantite
  Vente setQuantite(int newQuantite) {
    return Vente(
      objet: this.objet,
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
      annonceAchat: this.annonceAchat,

    );
  }
}