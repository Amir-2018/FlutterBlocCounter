class Contact {
  final int? id;
  final int? id_etablissement ;
  final String nom;
  final String email;
  final String telephone;

  const Contact({
    required this.id,
    required this.id_etablissement  ,
    required this.nom,
    required this.email,
    required this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      id_etablissement: json['id_etablissement'],
      nom: json['nom'],
      email: json['email'],
      telephone: json['telephone'],
    );
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      id_etablissement: map['id_etablissement'],
      nom: map['nom'],
      email: map['email'],
      telephone: map['telephone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_etablissement': id_etablissement,
      'nom': nom,
      'email': email,
      'telephone': telephone,
    };
  }
}