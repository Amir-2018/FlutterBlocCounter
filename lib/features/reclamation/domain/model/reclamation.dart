class Reclamation {
  final int? id;
  final String sujet;
  final String? contenu;
  final String email;
  final String? photo;
  final String etat;
  final bool isChecked;



  const Reclamation({
    this.id,
    required this.sujet,
    required this.contenu,
    required this.email,
    required this.photo,
    required this.etat,
    required this.isChecked,


  });
  factory Reclamation.fromJson(Map<String, dynamic> json) {
    return Reclamation(
      id: json['id'],
      sujet: json['sujet'],
      contenu: json['contenu'],
      email: json['email'],
      photo: json['photo'],
      etat: json['etat'],
      isChecked: json['isChecked'],

    );
  }

  factory Reclamation.fromMap(Map<dynamic, dynamic> map) {
    return Reclamation(
      sujet: map['sujet'],
      contenu: map['contenu'],
      email: map['email'],
      photo: map['photo'],
      etat: map['etat'],
      isChecked: map['isChecked'],


    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'sujet': photo,
      'contenu': contenu,
      'email': email,
      'pohto': photo,
      'etat': etat,
      'isCheked': isChecked,



    };
  }

}

