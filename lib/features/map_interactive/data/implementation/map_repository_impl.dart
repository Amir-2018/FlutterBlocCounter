import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';
import 'package:http/http.dart' as http;
import '../../../../core/connection_management.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/model/contact.dart';
import '../../domain/repository/map_repository.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';
import 'package:latlong2/latlong.dart';

class MapRepositoryImpl extends MapRepository {

  Future<List<Establishment>> getEstablishmentsWithPositionAndContacts(DatabaseHelper databaseHelper) async {

    List<Establishment> newList = [];

    List<Map<String, dynamic>> list = await databaseHelper.getAllEstablishments();

    for (Map<String, dynamic> establishment in list) {
      Map<String, dynamic> newEstablishment = Map.from(establishment);

      // Extracting latitude and longitude from the string representation
      String positionString = establishment['position'];
      List<String> parts = positionString.split(RegExp(r'[=,{}]')); // Split by '=', ',' and '}'

      if (parts.length >= 4) {
        double lat = double.tryParse(parts[3]) ?? 0.0; // Parsing latitude
        double lng = double.tryParse(parts[1]) ?? 0.0; // Parsing longitude

        newEstablishment['position'] = PointLocation(lat: lat, lng: lng);
      } else {
        // Handle invalid format
        debugPrint('Invalid format for position: $positionString');
        continue; // Skip this establishment
      }

      newEstablishment['contacts'] = await databaseHelper.getAllContactsByEstablishmentId(establishment['id']);
      // Just put request here when it is available
      newEstablishment['lots'] = [];
      debugPrint('Instance of New Establishment: $newEstablishment');

      newList.add(Establishment.fromJson(newEstablishment));
    }

    return newList;
  }
  // Function that return Poinst location Instance from String
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
  // Function that get code from database
  Future<List<Establishment>> getEstablishmentsFromDatabase(DatabaseHelper databaseHelper) async {

    List<Establishment> newList = [];

    Future<List<Map<String, dynamic>>> listEstablishmentFromLocal = databaseHelper.getAllEstablishments();

    List<Map<String, dynamic>> list = await listEstablishmentFromLocal;

    for (Map<String, dynamic> establishment in list) {
      debugPrint('before ${establishment['id']}');

      Map<String, dynamic> newEstablishment = Map.from(establishment);

      // Extracting latitude and longitude from the string representation

      String positionString = establishment['position'];

      newEstablishment['contacts'] = await databaseHelper.getAllContactsByEstablishmentId(establishment['id']);

      // Just put request here when it is available
      newEstablishment['lots'] = [];
      // Create new object to save the establishment
      Map<String, dynamic> positionLocation = getPointLocationFromString(positionString).toMap();
      // add point after casting from string to PointLocation
      newEstablishment['position'] = positionLocation;
      // Add the establishment to the list of Establishment
      newList.add(Establishment.fromMap(newEstablishment));
    }

    return newList;
  }

  @override
  Future<List<Establishment>> getEstablishments() async {
    // Initialise the database
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

    await databaseHelper.initializeDatabase();
    // Verify internet connection
    bool isConnected = await checkConnection();
    List<Establishment> newList = [];
    if (isConnected) {

        final response = await http.get(
          Uri.parse('http://172.19.0.55:8081/etablissements'),
        );
        if (response.statusCode == 200) {

          // Get response as map response
          List<dynamic> establishmentsData = jsonDecode(response.body);

          List<Establishment> establishments = establishmentsData
              .map((establishment) => (Establishment.fromJson(establishment)))
              .toList();
          // delete lots and contacts
          bool isEstablishmentsDeleted  = await databaseHelper.deleteAllEstablishmentsAndCheckIfEmpty() ;

          // Insert list in the database
          if(isEstablishmentsDeleted){
            debugPrint('Deleted with sucess') ;
          }else{
            debugPrint('Not Deleted') ;
          }
          // Delete all contact related to establishment
          bool isAllContactsDeleted  = await databaseHelper.deleteAllContacts() ;
          if(isAllContactsDeleted){
            debugPrint('All contacts are deleted with success') ;
          }else{
            debugPrint('Failed to delete all contacts') ;
          }
          // Insert establishments and contacts
          bool isInserted = await databaseHelper.insertEstablishments(establishments);
          if(isInserted){
            debugPrint('Inserted with success') ;
            Zone myZone  = await databaseHelper.getZoneById(1) ;
            debugPrint('zone by id = ${myZone.toMap()}') ;
          }else{
            debugPrint('Failure to insert') ;
          }
          // Get Establishment  from database
          return getEstablishmentsFromDatabase(databaseHelper) ;
        } else {
          throw Exception('Failed to fetch establishments: ${response.statusCode}');
        }

    } else {
      // If there is no internet connection Get Establishment  from database
      return getEstablishmentsFromDatabase(databaseHelper) ;
    }
  }

  @override
  Future<List<Lot>> getLots() async {
    // Initialise connection to Database
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

    await databaseHelper.initializeDatabase();

    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {


        final response = await http.get(
          Uri.parse('http://172.19.0.55:8081/lots'),
        );

        if (response.statusCode == 200) {
          debugPrint('Good job response is 200 my freind') ;
          List<dynamic> lotsData = jsonDecode(response.body);
          List<Lot> lots = lotsData
              .map((lot) => Lot.fromJson(lot))
              .toList();
          debugPrint(lots.toString()) ;
          bool isDeleted = await databaseHelper.deleteAllLots();
          if(isDeleted){
            debugPrint('Deleted with sucess') ;
          }else{
            debugPrint('Not deleted freind') ;
          }
          bool isInserted = await databaseHelper.insertLots(lots);
          if(isInserted){
            debugPrint('Inserted with success') ;
          }else{
            debugPrint('Not Inserted in database') ;

          }
          List<Lot> lotLocal = await databaseHelper.getAllLots() ;
          return lotLocal ;
          return lots ;
          // Delete all Lots from database

          // Insert New Lots

          // Get all lots from Database
          // Returning Lots
        } else {
          throw Exception('Failed to fetch lots: ${response.statusCode}');
        }

    } else {
      List<Lot> lotLocal = await databaseHelper.getAllLots() ;
      return lotLocal ;
    }
  }
  // Parse bordures en une list des Location
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
  Future<Zone> processZones(DatabaseHelper databaseHelper) async {
    List<Map<String, dynamic>> zones = await databaseHelper.getZones();
    debugPrint('Zone getted with success');

    if (zones.isNotEmpty) {
      debugPrint(zones.length.toString());

      // Convertir la liste des points format string en LocationPoint
      List<PointLocation> pointLocationList = stringToPointLocationList(zones[0]['bordures']);
      debugPrint('bordures are ${pointLocationList.toString()}');

      Map<String, dynamic> newZoneMap = {
        'id': zones[0]['id'],
        'bordures': stringToPointLocationList(zones[0]['bordures']),
        'nom': zones[0]['nom'],
        'nombre_lots': zones[0]['nombre_lots'],
      };

      debugPrint('zone before $newZoneMap');
      // Convertir l'objet de la base en un objet zone
      Zone newZones = Zone.fromMap(newZoneMap);
      //debugPrint('zone after ${jsonEncode(newZoneMap)}');

      return newZones;
    }

    throw Exception("No zones found in the database");
  }
  @override
  Future<Zone> getZone() async {
    // Vérifier la connexion
    bool isConnected = await checkConnection();
    Zone newZones = Zone.empty();
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();
    String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');
    if (token != null) {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      if (isConnected) {
        try {
          final response = await http.get(
            Uri.parse('http://172.19.0.55:8081/zones/Chotrana_II'),
            headers: headers,
          );
          if (response.statusCode == 200) {
            debugPrint('Good job');
            Map<String, dynamic> zoneData = jsonDecode(response.body);
            Zone newZone = Zone.fromJson(zoneData);
            debugPrint('Good job${newZone.bordures}');
            // delete offlines zones
            bool isDeleted = await databaseHelper.deleteAllZones();
            if (isDeleted) {
              await databaseHelper.insertZone(newZone);
              List<Map<String, dynamic>> zones = await databaseHelper.getZones();
              if (zones.isNotEmpty) {
                debugPrint(zones.length.toString());

                // Convertir la liste des points format string en LocationPoint
                List<PointLocation> pointLocationList = stringToPointLocationList(zones[0]['bordures']);
                debugPrint('bordures are ${pointLocationList.toString()}');

                Map<String, dynamic> newZoneMap = {
                  'id': zones[0]['id'],
                  'bordures': stringToPointLocationList(zones[0]['bordures']),
                  'nom': zones[0]['nom'],
                  'nombre_lots': zones[0]['nombre_lots'],
                };

                debugPrint('zone before $newZoneMap');
                // Convertir l'objet de la base en un objet zone
                newZones = Zone.fromMap(newZoneMap);
                debugPrint('zone after ${jsonEncode(newZoneMap)}');
              }
            }
          } else {
            throw Exception('Response status code: ${response.statusCode}');
          }
        } catch (e) {
          debugPrint('Error while fetching zone: $e');
          return processZones(databaseHelper);
        }
      } else {
        return processZones(databaseHelper);
      }
    } else {
      throw Exception("Error not handled");
    }

    return newZones;
  }

  /*@override
  Future<List<Establishment>> getEtablissements() async {
    bool isConnected = await checkConnection();
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();

    if (isConnected) {
      try {
        final response = await http.get(
          Uri.parse('http://172.19.0.55:8081/etablissements'),
        );
        if (response.statusCode == 200) {
          List<dynamic> etablissementsJson = jsonDecode(response.body);
          List<Establishment> etablissements = etablissementsJson.map((etablissementJson) => Establishment.fromJson(etablissementJson)).toList();
          debugPrint('Good job impl is ${etablissements.toString()}');
          return etablissements;
        } else {
          throw Exception('Response status code: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error while fetching etablissements: $e');
        throw Exception('Response status code: ');      }
    } else {
      throw Exception('Response status code:');    }
  }*/
}