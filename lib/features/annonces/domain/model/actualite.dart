class Actualite {
  final int? id;
  final String titre;
  final String? photo;
  final String description;
  final String? date;
  final String contact;
  final String type;
  final int confirmed;


  const Actualite({
    this.id,
    required this.titre,
    required this.photo,
    required this.description,
    required this.date,
    required this.contact,
    required this.type,
    required this.confirmed




  });
  factory Actualite.fromJson(Map<String, dynamic> json) {
    return Actualite(
      id: json['id'],
      titre: json['titre'],
      photo: json['photo'],
      description: json['description'],
      date: json['date'],
      contact: json['contact'],
      type: json['type'],
      confirmed: json['confirmed'] == true ? 1 : 0,
    );
  }


  factory Actualite.fromMap(Map<dynamic, dynamic> map) {
    return Actualite(
      titre: map['titre'],
      photo: map['photo'],
      description: map['description'],
        date: map['date'],
        contact: map['contact'],
        type: map['type'],
        confirmed: map['confirmed'] == true ? 1 : 0,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'titre': titre,
      'photo': photo,
      'description': description,
      'date': date,
      'contact': contact,
      'type': type,
      'confirmed': confirmed





    };
  }

  // Getter for id
  int? get getId => id;

  // Setter for id
  Actualite setId(int? newId) {
    return Actualite(
      id: newId,
      titre: this.titre,
      photo: this.photo,
      description: this.description,
      date: this.date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,



    );
  }

  // Getter for titre
  String get getTitre => titre;

  // Setter for titre
  Actualite setTitre(String newTitre) {
    return Actualite(
      id: this.id,
      titre: newTitre,
      photo: this.photo,
      description: this.description,
      date: this.date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,




    );
  }

  // Getter for photo

  // Setter for photo
  Actualite setPhoto(String newPhoto) {
    return Actualite(
      id: this.id,
      titre: this.titre,
      photo: newPhoto,
      description: this.description,
      date: this.date,
      contact: this.contact,
      type: this.type,
      confirmed: this.confirmed,




    );
  }

  // Getter for photo

  // Setter for photo
  Actualite setDate(String newDate) {
    return Actualite(
      id: this.id,
      titre: this.titre,
      photo: this.photo,
      description: this.description,
      date: newDate,
      contact: contact,
      type: type,
      confirmed: confirmed,





    );
  }

  // Getter for description
  String get getDescription => description;

  // Setter for description
  Actualite setDescription(String newDescription) {
    return Actualite(
      id: this.id,
      titre: this.titre,
      photo: this.photo,
      description: newDescription,
      date: date,
      contact: contact,
      type: type,
      confirmed: confirmed,




    );
  }
}

