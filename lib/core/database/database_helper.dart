import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/domain/model/covoiturage_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';
import '../../features/annonces/domain/model/actualite.dart';
import '../../features/map_interactive/domain/model/contact.dart';
import '../../features/map_interactive/domain/model/establishment.dart';
import '../../features/map_interactive/domain/model/lot.dart';
import '../../features/map_interactive/domain/model/point_location.dart';
import '../../features/venteAchat/domain/model/vente.dart';
import '../../features/authentication/domain/model/user.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dbtestsesfsddqssisssqqscsswsqqssnssssswqssszegdq.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, telephone TEXT, establishment TEXT, post TEXT, cin TEXT)',
        );
        await db.execute(
          'CREATE TABLE zone(id INTEGER PRIMARY KEY, nom TEXT, nombre_lots INTEGER, bordures TEXT)',
        );
        await db.execute('CREATE TABLE contact (id INTEGER PRIMARY KEY, id_etablissement INTEGER, nom TEXT, email TEXT, telephone TEXT, FOREIGN KEY (id_etablissement) REFERENCES establishment(id))');
        await db.execute('CREATE TABLE establishment (id INTEGER PRIMARY KEY, nom TEXT, telephone TEXT, fax TEXT, categorie TEXT, surface TEXT, lien TEXT, position TEXT)');
        await db.execute('CREATE TABLE lots (id INTEGER PRIMARY KEY,numero INTEGER,etat BOOLEAN,bordures TEXT,id_etablissement INTEGER,id_zone INTEGER)');
        await db.execute('CREATE TABLE actualites (id INTEGER PRIMARY KEY,titre TEXT,description TEXT,photo TEXT,date TEXT,type TEXT,contact TEXT,confirmed INTEGER)');
        await db.execute('CREATE TABLE ventes (id INTEGER PRIMARY KEY,titre TEXT,objet TEXT, prix Real, quantite INTEGER, description TEXT,photo TEXT,date TEXT,contact TEXT,confirmed INTEGER,annonceAchat INTEGER,type TEXT)');
        //await db.execute('CREATE TABLE achats (id INTEGER PRIMARY KEY,titre TEXT,objet TEXT, prix Real, quantite Real, description TEXT,photo TEXT,date TEXT,contact TEXT,confirmed INTEGER)');
        await db.execute('CREATE TABLE covoiturages (id INTEGER PRIMARY KEY,depart TEXT,destination TEXT, description TEXT, photo TEXT,titre TEXT,nb_personnes INTEGER,temps_depart TEXT,date TEXT,contact TEXT,type TEXT,cotisation Real,confirmed INTEGER)');

      },
    );
  }

  Future<void> insertUser(User user) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.insert('user', user.toMap());
  }


  Future<List<User>> getUsers() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query('user');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        email: maps[i]['email'],
        telephone: maps[i]['telephone'],
        establishment: maps[i]['establishment'],
        post: maps[i]['post'],
        cin: maps[i]['cin'],
      );
    });
  }

  Future<User?> getFirstUser() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> users = await _database!.query(
      'my_table',
      where: 'username = ?',
      whereArgs: ['Amir'],
      limit: 1,
    );

    if (users.isNotEmpty) {
      return User(
        id: users[0]['id'],
        username: users[0]['username'],
        password: users[0]['password'],
        email: users[0]['email'],
        telephone: users[0]['telephone'],
        establishment: users[0]['establishment'],
        post: users[0]['post'],
        cin: users[0]['cin'],
      );
    }

    return null; // Return null if no user with the name "Amir" is found
  }

  Future<bool> deleteAllUsers() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    int rowsDeleted = await _database!.delete('user'); // Delete all rows from the 'my_table' table

    return rowsDeleted > 0; // Return true if rows were deleted, false otherwise
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
    }
  }
  /* Zone management */
  Future<void> insertZone(Zone zone) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<String> borduresStrings = [];
    for (PointLocation bordure in zone.bordures) {
      String bordureString = '${bordure.lat}|${bordure.lng}';
      borduresStrings.add(bordureString);
    }
    String borduresConcatenated = borduresStrings.join(';');

    Map<String, dynamic> zoneMap = zone.toMap();
    zoneMap['bordures'] = borduresConcatenated;

    // Remove lots field from zoneMap

    await _database!.insert(
      'zone',
      zoneMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
    /*Get zone */
  Future<List<Map<String, dynamic>>>getZones() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query('zone');
    debugPrint(maps.toString());
    return maps;
  }

  Future<bool> deleteAllZones() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.delete('zone');
      return true;
    } catch (e) {
      debugPrint('Error deleting all zones: $e');
      return false;
    }
  }
/********************* Establishment code*********************/
  Future<bool> insertEstablishments(List<Establishment> establishments) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    bool success = true;
    for (Establishment establishment in establishments) {
      int result = await _database!.insert('establishment', establishment.toMap());
      debugPrint('tawwwwwwww ${establishment.toMap()}') ;
      if(establishment.id!=null){
        debugPrint('I will insert the contact') ;

        //int result = await _database!.insert('establishment', establishment.toMap());
        for (Contact contact in establishment.contacts) {
          Contact ctn = Contact(id: contact.id, id_etablissement: establishment.id, nom: contact.nom, email: contact.email, telephone: contact.telephone) ;
          debugPrint('I will insert the contact') ;

          int resultContact = await _database!.insert('contact', ctn.toMap());
          if(resultContact == 0){
            debugPrint('I Insert all contacts') ;
          }else{
            debugPrint('Failure to insert Contacts') ;

          }

        }
      }else{
        debugPrint('Id establishment is null') ;
      }
      if (result == 0) {
        success = false;
        break;
      }
    }

    return success;
  }
  // Funtion that delete all establishment

  Future<bool> deleteAllEstablishmentsAndCheckIfEmpty() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.delete('establishment');
    List<Map<String, dynamic>> rows = await _database!.query('establishment');
    return rows.isEmpty;
  }
  // Fetch all establishments
  Future<List<Map<String, dynamic>>> getAllEstablishments() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> rows = await _database!.query('establishment');
    return rows;
  }
  // delete all contacts related related to the establishment
  Future<bool> deleteAllContacts() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> contacts = await _database!.query('contact');
    if (contacts.length > 0) {
      int result = await _database!.delete('contact');
      return result > 0;
    } else {
      debugPrint('Contact table is already empty');
      return false;
    }
  }

  // get All contacs
  Future<List<Contact>> getAllContactsByEstablishmentId(int idEtablissement) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> contacts = await _database!.query('contact', where: 'id_etablissement = ?', whereArgs: [idEtablissement]);
    return contacts.map((contact) => Contact.fromMap(contact)).toList();
  }
  // Get Establishment by Id

  PointLocation getPointLocationFromString(String positionString) {
    List<String> parts = positionString.split(RegExp(r'[=,{}]'));

    if (parts.length >= 4) {

      double lat = double.tryParse(parts[2]) ?? 0.0; // Latitude is at index 2

      double lng = double.tryParse(parts[4]) ?? 0.0; // Longitude is at index 4

      return PointLocation(lat: lng, lng: lat);
    } else {
      // Handle invalid format
      return PointLocation(lat: 0.0, lng: 0.0); // Return default values or handle error
    }
  }

  Future<Establishment> getEstablishmentByIdEtablissement(int idEtablissement) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> establishmentMaps = await _database!.query(
      'establishment',
      where: 'id = ?',
      whereArgs: [idEtablissement],
      limit: 1,
    );

    if (establishmentMaps.isNotEmpty) {
      Map<String, dynamic> establishmentMap = establishmentMaps.first;
       debugPrint('testttt${establishmentMap['position']}') ;
      return Establishment(
        id: establishmentMap['id'] as int,
        nom: establishmentMap['nom'],
        lots: [], // Assuming you have a way to fetch the lots separately
        telephone: establishmentMap['telephone'],
        fax: establishmentMap['fax'],
        contacts: [], // Assuming you have a way to fetch the contacts separately
        categorie: establishmentMap['categorie'],
        surface: establishmentMap['surface'],
        lien: establishmentMap['lien'],
        position: getPointLocationFromString(establishmentMap['position']),
      );
    } else {
      return Establishment(nom: "empty", lots: [], telephone: "123", fax: "123", contacts: [], categorie: "affaires", surface: "10.0", lien: 'ee', position: PointLocation(lat: 0.0,lng: 0.0));
    }
  }

  // Get zone by id
  Future<Zone> getZoneById(int idZone) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> zoneMaps = await _database!.query(
      'zone',
      where: 'id = ?',
      whereArgs: [idZone],
      limit: 1,
    );

    if (zoneMaps.isNotEmpty) {
      Map<String, dynamic> zoneMap = zoneMaps.first;
      return Zone(
        id: zoneMap['id'] as int,
        bordures: stringToPointLocationList(zoneMap['bordures']),
        nom: zoneMap['nom'],
        nombre_lots: zoneMap['nombre_lots'],
      );
    } else {
      return Zone.empty();
    }
  }
  /********************* Establishment code*********************/
/******************** Lots code ***********************************/

  List<PointLocation> stringToPointLocationList(String bordures) {

    List<String> substrings = bordures.split(';');
    List<PointLocation> pointLocationList = [];

    for (String substring in substrings) {
      List<String> latLng = substring.split('|');
      double lat = double.parse(latLng[0]);
      double lng = double.parse(latLng[1]);
      PointLocation pointLocation = PointLocation(lat: lat, lng: lng);
      pointLocationList.add(pointLocation);
    }

    return pointLocationList;
  }

  Future<String> getBorduresStringFromPointLocations(List<PointLocation> pointLocations) async {
    List<String> borduresStrings = [];

    for (PointLocation bordure in pointLocations) {
      String bordureString = '${bordure.lat }|${bordure.lng }';
      borduresStrings.add(bordureString);
    }

    String borduresConcatenated = borduresStrings.join(';');
    return borduresConcatenated;
  }

  Future<bool> insertLots(List<Lot> lots) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.transaction((txn) async {
        for (final lot in lots) {
          await txn.insert(
            'lots',
            {
              'numero': lot.numero,
              'etat': lot.etat ? 1 : 0, // Convert boolean to integer for SQLite
              'bordures': await getBorduresStringFromPointLocations(lot.bordures),
              'id_etablissement': lot.establishment.id,
              'id_zone': lot.zone.id, // Use the id_etablissement from the Establishment

            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      return true; // Return true if the insertion is successful
    } catch (e) {
      print('Error inserting lots: $e');
      return false; // Return false if an error occurs during insertion
    }
  }
// Get all lots from database
  Future<bool> deleteAllLots() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.delete('lots');
      return true; // Return true if the deletion is successful
    } catch (e) {
      print('Error deleting lots: $e');
      return false; // Return false if an error occurs during deletion
    }
  }

  Future<List<Lot>> getAllLots() async {
    List<Lot> lots = [];

    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      List<Map<String, dynamic>> lotMaps = await _database!.query('lots');// // Query all rows from the 'lots' table

      for (var lotMap in lotMaps) {
        debugPrint('numero = ${getEstablishmentByIdEtablissement(lotMap['id_etablissement'])}') ;
        debugPrint(' The lotMpae  is$lotMap') ;//
        Lot lot = Lot(
          numero: lotMap['numero'] as int,
          etat: lotMap['etat'] == 1,
          bordures: stringToPointLocationList(lotMap['bordures']),
          establishment: await getEstablishmentByIdEtablissement(lotMap['id_etablissement']), zone: await getZoneById(lotMap['id_zone']),
        );
        debugPrint('The lot is${lot.toMap()}') ;//

        lots.add(lot);
      }
    } catch (e) {
      print('Error getting lots: $e');
    }

    return lots;
  }

  List<PointLocation> _deserializeBordures(String borduresString) {
    return []; // Placeholder, replace with actual deserialization logic
  }


  /******************************** Actualites ***********************************/
  Future<bool> insertActualites(List<Actualite> actualites) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.transaction((txn) async {
        for (var actualite in actualites) {
          await txn.insert(
            'actualites',
            {
              'id': actualite.id,
              'titre': actualite.titre,
              'photo': actualite.photo,
              'description': actualite.description,
              'date': actualite.date,
              'contact': actualite.contact,
              'type': actualite.type,

              'confirmed': actualite.confirmed,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      return true; // Return true if all actualites are successfully inserted
    } catch (e) {
      print('Error inserting actualites: $e');
      return false; // Return false if an error occurs during insertion
    }
  }


  Future<bool> insertActualite(Actualite actualite) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.transaction((txn) async {
        await txn.insert(
          'actualites',
          {
            'id': actualite.id,
            'titre': actualite.titre,
            'photo': actualite.photo,
            'description': actualite.description,
            'date': actualite.date,
            'contact': actualite.contact,


          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
      return true; // Return true if the insertion is successful
    } catch (e) {
      print('Error inserting actualite: $e');
      return false; // Return false if an error occurs during insertion
    }
  }

  Future<List<Actualite>> getAllActualites(int page,int pageSize) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query('actualites',
      limit: pageSize,
      offset: page * pageSize,
      orderBy: 'id DESC', // Replace 'yourColumnName' with the column you want to order by

    );

    return List.generate(maps.length, (index) {

      return Actualite(
        id: maps[index]['id'],
        titre: maps[index]['titre'],
        photo: maps[index]['photo'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        type: maps[index]['type'],
        confirmed: maps[index]['confirmed']== true ? 1 : 0,

      );
    });
  }

  Future<List<Actualite>> getAllActualitesOfToday() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'actualites',
      limit: 4, // Limit to 4 results
      orderBy: 'date DESC', // Order by date in descending order
    );

    return List.generate(maps.length, (index) {
      return Actualite(
        id: maps[index]['id'],
        titre: maps[index]['titre'],
        photo: maps[index]['photo'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        type: maps[index]['type'],
        confirmed: maps[index]['confirmed'] == true ? 1 : 0,
      );
    });
  }

  Future<List<Actualite>> getAllActualitesByTitre( int page, int pageSize,String title,) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'actualites',
      where: 'titre LIKE ?',
      whereArgs: ['%$title%'],
      orderBy: 'id DESC',
      limit: pageSize,
      offset: page * pageSize,
    );

    return List.generate(maps.length, (index) {
      return Actualite(
        id: maps[index]['id'],
        titre: maps[index]['titre'],
        photo: maps[index]['photo'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        confirmed: maps[index]['confirmed'],
        type: maps[index]['type'],

      );
    });
  }

  Future<List<String>> getAllActualiteTitles() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'actualites',
      columns: ['titre'],
    );

    return List.generate(maps.length, (index) {
      return maps[index]['titre'] as String;
    });
  }
  Future<List<String>> getAllCovoiturageTitles() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'covoiturages',
      columns: ['titre'],
    );

    return List.generate(maps.length, (index) {
      return maps[index]['titre'] as String;
    });
  }
  Future<List<String>> getAllVentesByTitres() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> ventesMaps = await _database!.query(
      'ventes',
      columns: ['titre'],
    );

    final List<String> allTitres = ventesMaps.map((map) => map['titre'] as String).toSet().toList();

    return allTitres;
  }

  Future<void> deleteAllActualites() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.delete('actualites');

    print('All actualites deleted successfully');
  }
/******************************** Actualites ***********************************/

  /**************************************** Servives Vente Achat ********************************/
  Future<bool> insertVentes(List<Vente> ventes) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      // Ouvrir une transaction pour insérer toutes les ventes en une seule fois
      await _database!.transaction((txn) async {
        for (final vente in ventes) {
          await txn.insert('ventes', vente.toMap());
        }
      });
      return true; // Retourne true si l'insertion a réussi
    } catch (e) {
      // Gérer les erreurs d'insertion
      print('Erreur lors de l\'insertion des ventes: $e');
      return false;
    }
  }

  Future<List<Vente>> getAllVentesOuAchats(int page, int pageSize, int numtable) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'ventes', // Rechercher uniquement dans la table 'ventes'
      limit: pageSize,
      offset: page * pageSize,
      orderBy: 'id DESC',
      where: 'annonceAchat = ?',
      whereArgs: [numtable], // Valeur de numtable pour la condition

    );

    return List.generate(maps.length, (index) {
      //print(maps[index]['annonceAchat']) ;
      return Vente(
        objet: maps[index]['objet'],
        prix: maps[index]['prix'],
        quantite: maps[index]['quantite'],
        id: maps[index]['id'],
        titre: maps[index]['titre'],
        photo: maps[index]['photo'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        type: maps[index]['type'],
        confirmed: maps[index]['confirmed'],
        annonceAchat: maps[index]['annonceAchat'],
      );
    });
  }
  Future<List<Vente>> getAllVentes(int page, int pageSize) async {

    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> ventesMap = await _database!.query(
      'ventes',
      limit: pageSize,
      offset: page * pageSize,
      orderBy: 'id DESC',
    );

    final List<Vente> allVentes = List.generate(ventesMap.length, (index) {
      print(ventesMap[index]['quantite']) ;
      print(ventesMap[index]['confirmed']) ;
      return Vente(
        objet: ventesMap[index]['objet'],
        prix: ventesMap[index]['prix'],
        quantite: ventesMap[index]['quantite'],
        id: ventesMap[index]['id'],
        titre: ventesMap[index]['titre'],
        photo: ventesMap[index]['photo'],
        description: ventesMap[index]['description'],
        date: ventesMap[index]['date'],
        contact: ventesMap[index]['contact'],
        type: ventesMap[index]['type'],
        confirmed: ventesMap[index]['confirmed'],
        annonceAchat: ventesMap[index]['annonceAchat'],
      );
    });

    return allVentes;
  }

  Future<List<Vente>> getAllVentesByTitre(int page, int pageSize, String title) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> ventesMaps = await _database!.query(
      'ventes',
      where: 'titre LIKE ?',
      whereArgs: ['%$title%'],
      orderBy: 'id DESC',
      limit: pageSize,
      offset: page * pageSize,
    );

    final List<Vente> ventes = List.generate(ventesMaps.length, (index) {
      return Vente(
        objet: ventesMaps[index]['objet'],
        prix: ventesMaps[index]['prix'],
        quantite: ventesMaps[index]['quantite'],
        id: ventesMaps[index]['id'],
        titre: ventesMaps[index]['titre'],
        photo: ventesMaps[index]['photo'],
        description: ventesMaps[index]['description'],
        date: ventesMaps[index]['date'],
        contact: ventesMaps[index]['contact'],
        type: ventesMaps[index]['type'],
        confirmed: ventesMaps[index]['confirmed'] ,
        annonceAchat: ventesMaps[index]['annonceAchat'],



      );
    });

    if (ventes.isEmpty) {
      final List<Map<String, dynamic>> achatsMaps = await _database!.query(
        'achats',
        where: 'titre LIKE ?',
        whereArgs: ['%$title%'],
        orderBy: 'id DESC',
        limit: pageSize,
        offset: page * pageSize,
      );

      return List.generate(achatsMaps.length, (index) {
        return Vente(
          objet: achatsMaps[index]['objet'],
          prix: achatsMaps[index]['prix'],
          quantite: achatsMaps[index]['quantite'],
          id: achatsMaps[index]['id'],
          titre: achatsMaps[index]['titre'],
          photo: achatsMaps[index]['photo'],
          description: achatsMaps[index]['description'],
          date: achatsMaps[index]['date'],
          contact: achatsMaps[index]['contact'],
          type: achatsMaps[index]['type'],
          annonceAchat: achatsMaps[index]['annonceAchat'],
          confirmed: achatsMaps[index]['confirmed'] == true ? 1 : 0,


        );
      });
    }

    return ventes;
  }
/**************************************** Servives Vente Achat ********************************/

  Future<void> deleteAllVentes() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.delete('ventes');
  }
  Future<void> deleteAllAchats() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.delete('achats');
  }
  Future<bool> insertCovoiturages(List<CovoiturageModel> covoiturages) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      await _database!.transaction((txn) async {
        for (var covoiturage in covoiturages) {
          await txn.insert(
            'covoiturages',
            {
              'id': covoiturage.id,
              'depart': covoiturage.depart,
              'destination': covoiturage.destination,
              'description': covoiturage.description,
              'photo': covoiturage.photo,
              'titre': covoiturage.titre,
              'nb_personnes': covoiturage.nb_personnes,
              'temps_depart': covoiturage.temps_depart,
              'date': covoiturage.date,
              'contact': covoiturage.contact,
              'type': covoiturage.type,
              'cotisation': covoiturage.cotisation,
              'confirmed': covoiturage.confirmed == true ? 1 : 0,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      return true; // Return true if all covoiturages are successfully inserted
    } catch (e) {
      print('Error inserting covoiturages: $e');
      return false; // Return false if an error occurs during insertion
    }
  }
  Future<List<CovoiturageModel>> getAllCovoituragesByTitre(int page, int pageSize, String title) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query(
      'covoiturages',
      where: 'titre LIKE ?',
      whereArgs: ['%$title%'],
      orderBy: 'id DESC',
      limit: pageSize,
      offset: page * pageSize,
    );

    return List.generate(maps.length, (index) {
      return CovoiturageModel(
        id: maps[index]['id'],
        depart: maps[index]['depart'],
        destination: maps[index]['destination'],
        description: maps[index]['description'],
        photo: maps[index]['photo'],
        titre: maps[index]['titre'],
        nb_personnes: maps[index]['nb_personnes'],
        temps_depart: maps[index]['temps_depart'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        type: maps[index]['type'],
        cotisation: maps[index]['cotisation'],
        confirmed: maps[index]['confirmed'] ,
      );
    });
  }

  Future<void> deleteAllCovoiturages() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.delete('covoiturages');

    print('All Covoiturages deleted successfully');
  }
  Future<int> deleteCovoiturage(int id) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    try {
      return await _database!.delete(
        'covoiturages',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting covoiturage: $e');
      return 0; // Return 0 if an error occurs during deletion
    }
  }
  Future<List<CovoiturageModel>> getAllCovoiturages(int page, int pageSize) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query('covoiturages',
      limit: pageSize,
      offset: page * pageSize,
      orderBy: 'id DESC', // Replace 'yourColumnName' with the column you want to order by

    );

    return List.generate(maps.length, (index) {
      return CovoiturageModel(
        id: maps[index]['id'],
        depart: maps[index]['depart'],
        destination: maps[index]['destination'],
        description: maps[index]['description'],
        photo: maps[index]['photo'],
        titre: maps[index]['titre'],
        nb_personnes: maps[index]['nb_personnes'],
        temps_depart: maps[index]['temps_depart'],
        date: maps[index]['date'],
        contact: maps[index]['contact'],
        type: maps[index]['type'],
        cotisation: maps[index]['cotisation'],
        confirmed: maps[index]['confirmed'] ,
      );
    });
  }
}



Future<bool> deleteTokenFromStorage() async {
  final storage =   FlutterSecureStorage();

  String? value = await storage.read(key: 'access_token');
  if (value != null) {
    debugPrint('Connected') ;
    await storage.delete(key: 'access_token');
    String? tokenagain = await storage.read(key: 'access_token');
    debugPrint('Token is $tokenagain') ;

    return true; // Token successfully deleted
  } else {
    debugPrint('Disconnect') ;
    return false; // Token not found or deletion failed
  }
}
