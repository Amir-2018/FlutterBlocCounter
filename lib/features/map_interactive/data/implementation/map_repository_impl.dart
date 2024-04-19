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
import '../../domain/repository/map_repository.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

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


  @override
  Future<Zone> getZone() async {
    List<PointLocation> borders = [
      PointLocation(lat: 36.8978188, lng: 10.1868324),
      PointLocation(lat: 36.8988555, lng: 10.1871929),
      PointLocation(lat: 36.8998611, lng: 10.1878452),
      PointLocation(lat: 36.9018309, lng: 10.1890168),
      PointLocation(lat: 36.9057404, lng: 10.1914930),
      PointLocation(lat: 36.9039220, lng: 10.1938319),
      PointLocation(lat: 36.9035983, lng: 10.1938663),
      PointLocation(lat: 36.9032873, lng: 10.1939821),
      PointLocation(lat: 36.9017520, lng: 10.1963983),
      PointLocation(lat: 36.9001734, lng: 10.1986084),
      PointLocation(lat: 36.8952280, lng: 10.1935616),
      PointLocation(lat: 36.8967064, lng: 10.1916969),
      PointLocation(lat: 36.8978046, lng: 10.1868260),
    ];

    // Création de l'instance de la classe Zone
    Zone maZone = Zone(
      id: 1,
      bordures: borders,
      nom: 'Example zone',
      etablissements: [
        const Establishment(
          id: 1,
          nom: 'Actia',
          telephone: '123-456-7890',
          fax: '987-654-3210',
          /*contacts: [
            Contact(id: 1, nom: 'John Doe', email: 'john.doe@example.com', telephone: '123456'),
            Contact(id: 2, nom: 'Jane Doe', email: 'jane.doe@example.com', telephone: '654321'),
          ],*/
          etablissementEnum: 'Example Type',
          surface: 100.0,
          lien: 'http://example.com',
          position: PointLocation(lat: 36.898473, lng: 10.187425),
          categorie: 'Example Category',
          lots: [],
        ),

        const Establishment(
          id: 2,
          nom: 'Wevioo',
          telephone: '123-456-7890',
          fax: '987-654-3210',
          /*contacts: [
            Contact(id: 1, nom: 'John Doe', email: 'john.doe@example.com', telephone: '123456'),
            Contact(id: 2, nom: 'Jane Doe', email: 'jane.doe@example.com', telephone: '654321'),
          ],*/
          etablissementEnum: 'Example Type',
          surface: 100.0,
          lien: 'http://example.com',
          position: PointLocation(lat: 36.901070, lng: 10.193663),
          categorie: 'Example Category',
          lots: [],
        ),

        const Establishment(
          id: 3,
          nom: 'Satem',
          telephone: '123-456-7890',
          fax: '987-654-3210',
          /*contacts: [
            Contact(id: 1, nom: 'John Doe', email: 'john.doe@example.com', telephone: '123456'),
            Contact(id: 2, nom: 'Jane Doe', email: 'jane.doe@example.com', telephone: '654321'),
          ],*/
          etablissementEnum: 'Example Type',
          surface: 200.0,
          lien: 'http://example.com',
          position: PointLocation(lat:36.898256, lng:  10.192118),
          categorie: 'Example Category',
          lots: [],
        ),
      ],
      nombre_lots: 0,
      lots: [],
    );
   //Zone zone = Zone.fromMap(newZone);
    //print(zone.toString());
    debugPrint('length ${maZone}') ;
    return maZone;
  }


}