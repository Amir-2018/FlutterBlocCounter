class Contact {
  final int id;
  final String nom;
  final String email;
  final String telephone;

  const Contact({
    required this.id,
    required this.nom,
    required this.email,
    required this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      telephone: json['telephone'],
    );
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      nom: map['nom'],
      email: map['email'],
      telephone: map['telephone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'telephone': telephone,
    };
  }
}