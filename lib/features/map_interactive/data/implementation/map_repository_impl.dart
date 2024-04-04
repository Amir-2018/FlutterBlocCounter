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
import '../../../../core/constantes.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../authentication/data/datasources/local/database_helper.dart';
import '../../domain/repository/map_repository.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:latlong2/latlong.dart';

import '../../presentation/widgets/map_elements/polylines.dart';


  // Sample JSON data for Zone
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:latlong2/latlong.dart';



  // Create an instance of Zone from JSON data
// Define the zone with one establishment and one lot
Map<String, dynamic> jsonData = {
  'id': 1,
  'nom': 'Chotrana 2 ',
  'establishment': {
    'id': 1,
    'nom': 'Sample Actia',
    'type': 'Type',
    'tel': '123456789',
    'fax': '987654321',
    'contact': 'John Doe',
    'surface': 'Sample Surface',
      'lots': [[
        [36.8984333, 10.1877530],
        [36.8978579, 10.1875582],
        [36.8977393, 10.1881100],
        [36.8983226, 10.1882832],
        [36.8984311, 10.1877540]
      ],[
        [36.8979814, 10.1869952],
        [36.8984933, 10.1872538],
        [36.8985158, 10.1873557],
        [36.8984333, 10.1877530],
        [36.8978579, 10.1875582],
        [36.8979817, 10.1869979]
      ],[
        [36.8977393, 10.1881100],
        [36.8983226, 10.1882832],
        [36.8982192, 10.1887973],
        [36.8976157, 10.1886885],
        [36.8977385, 10.1881137]
      ]],
    'position': const LatLng(36.898393, 10.187397),
  },
  'lots': [
    {
      'etat': 'Sample Etat',
      'etablissement': {
        'id': 2,
        'nom': 'Satem',
        'type': 'Type',
        'tel': '987654321',
        'fax': '123456789',
        'contact': 'Jane Doe',
        'surface': 'Sample Surface',
        'lots': [],
        'positions': const LatLng(36.901139, 10.192408
        ),
      },
      'position': polylines,
      'surface': 'Sample Surface',
      'prixCarre': 10.5,
    },
  ],
};

// Create a feature layer from the JSON data representing the zone
// This step involves transforming the JSON data into Graphic objects with attributes and geometry properties as described in the sources.
class MapRepositoryImpl extends MapRepository {

  @override
  Future<List<Establishment>> getEstablishments() async {
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');

      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse('https://example.com/api/establishments?type'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          List<dynamic> establishmentsData = jsonDecode(response.body);
          List<Establishment> establishments = establishmentsData
              .map((establishment) => Establishment.fromJson(establishment))
              .toList();
          debugPrint(establishments.toString()) ;

          // Return all establishments without filtering
          return establishments;
        } else {
          throw Exception('Failed to fetch establishments: ${response.statusCode}');
        }
      } else {
        throw Exception('Token not found');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Lot>> getLots() async {
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');

      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse('https://example.com/api/lots?type'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          List<dynamic> lotsData = jsonDecode(response.body);
          List<Lot> lots = lotsData
              .map((lot) => Lot.fromJson(lot))
              .toList();

          // Return all lots without filtering
          debugPrint(lots.toString()) ;
          return lots;
        } else {
          throw Exception('Failed to fetch lots: ${response.statusCode}');
        }
      } else {
        throw Exception('Token not found');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  /*@override
  Future<Zone> getZone() async {*/

   /* bool isConnected = await checkConnection(); // Vérifier la connexion
    // Mode connecté
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();

    if (isConnected) {
      String? token = await getIt<FlutterSecureStorage>().read(
          key: 'access_token');

      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse('$LINK/zone'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final zone =  Zone.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>);
              debugPrint(zone.toString()) ;
          debugPrint(zone.toString()) ;
          return zone;
        } else {
          throw Exception('Failed to fetch zone: ${response.statusCode}');
        }
      } else {
        throw Exception('Token not found');
      }
    } else {
      throw Exception('No internet connection');
    }*/
    /*Zone zone = Zone.fromJson(jsonData);
    debugPrint(zone.toString()) ;
    return zone ;
  }*/

  @override
  Future<Zone> getZone() async {
    Map<String, dynamic> zoneData = {
      'id': 1,
      'nom': 'Chotrana 2 ',
      'establishment': [
          {
          'id': 1,
          'nom': 'Actia ES',
          'type': 'Societé',
          'tel': '123-456-7890',
          'fax': '987-654-3210',
          'contact': 'John Doe',
          'surface': '200 sq km',
          'lots': [],
          'position': [36.898310, 10.187607],
          }
      ],
        'borders': polylines,
         'surface': '100 sq km',
        'lot': {
            'etat': 'Available',
            'etablissement': {'name': 'Sample Establishment'},
            'positions': [[40.73061, -73.935242], [37.774929, -122.419416]],
            'surface': '50 sq km',
            'prixCarre': 100.0
          },
         'lots': [],
          'positionMarqueur': [45.4215, -75.6972]


    };

    // Creating a Zone instance compatible with Establishment from the sample data

    Zone zone = Zone.fromJson(zoneData);


    print('the type of zone is $zone.runtimeType') ;

    // Outputting the created Zone instance
    print('Zone ID: ${zone.id}');
    print('Zone Name: ${zone.nom}');

// Printing Establishment details within the Zone
    print('Establishments:');
    for (var establishment in zone.establishment) {
      print('Establishment ID: ${establishment.id}');
      print('Establishment Name: ${establishment.nom}');
      print('Establishment Type: ${establishment.type}');
      // Print other establishment properties as needed
    }

// Printing Borders of the Zone
    print('Borders:');
    for (var border in zone.borders) {

      print('Latitude: ${border.latitude}, Longitude: ${border.longitude}');
    }

    print('Surface: ${zone.surface}');

// Printing Lots within the Zone
    print('Lots:');
    for (var lot in zone.lots) {
      print('Lot Etat: ${lot.etat}');
      print('Lot Surface: ${lot.surface}');
      // Print other lot properties as needed
    }

// Printing Position Marqueur of the Zone
    print('Position Marqueur: Latitude: ${zone.positionMarqueur.latitude}, Longitude: ${zone.positionMarqueur.longitude}');
    return zone ;
  }


}