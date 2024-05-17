import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';
import 'package:http/http.dart' as http;
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';
import '../../../../core/connection_management.dart';
import '../../domain/repository/evenement_repository.dart';

class EventRepositoryImpl extends EvenementRepository {

  @override
  Future<bool> insertEvent(Evenement event) async {
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');
      if (token != null) {
        print('Token is $token') ;
        print('The event  is $event') ;

        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        try {
          final response = await http.post(
            Uri.parse('http://172.19.0.55:8081/evenements'),
            encoding: Encoding.getByName('utf-8'),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              'titre': event.titre,
              'type': event.type,
              'category': event.category,
              'dateDebut': event.date_debut,
              'dateFin': event.date_fin,
              'photo': event.photo,
              'position': event.position,
              'localisation': event.localisation,
              'limite': event.limite,
              'description': event.description,
              'lienInscription' : event.lienInscription,
              'organisateur' : event.organisateur

            }),
          );

          if (response.statusCode == 201) {
            print('Amir rahy 200') ;
            // Handle successful insertion
            return true;
          } else {
            print(response.statusCode.toString());
            print(response.body) ;
            // Handle errors based on response.statusCode
            return false;
          }
        } catch (e) {
          // Handle exceptions or errors during the HTTP request
          print('Error: $e');
          return false;
        }
      }
    }
    return false; // Return false if token is null or not connected
  }

  @override
  Future<List<Evenement>> getEventsByUsername(String username) async {
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');
      if (token != null) {
        print('Token is $token');

        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        try {
          final response = await http.get(
            Uri.parse('http://172.19.0.55:8081/evenements/organisateur/amir'),
            headers: headers,
          );

          if (response.statusCode == 200) {
            var jsonData = jsonDecode(response.body);
            print(jsonData['data']) ;
            List<Evenement> events = (jsonData['data'] as List).map((json) {
              return Evenement(
                id: json['id'],
                type: json['type'],
                titre: json['titre'],
                description: json['description'],
                position: PointLocation.fromMap(json['position']),
                date_debut: json['dateDebut'],
                date_fin: json['dateFin'],
                limite: json['limite'],
                photo: json['photo'],
                category: json['category'],
                localisation: json['localisation'],
                organisateur: json['organisateur'],
                lienInscription: json['lienInscription'],
              );

            }).toList();

            return events;
          }  else {
            print(response.statusCode.toString());
            // Handle errors based on response.statusCode
            return [];
          }
        } catch (e) {
          // Handle exceptions or errors during the HTTP request
          print('Error: $e');
          return [];
        }
      }
    }
    return []; // Return an empty list if token is null or not connected
  }

  @override
  Future<bool> deleteEvent(int eventId) async {
    bool isConnected = await checkConnection(); // Check connection status

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');
      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        try {
          final response = await http.delete(
            Uri.parse('http://172.19.0.55:8081/evenements/$eventId'), // Endpoint for deleting event by ID
            headers: headers,
          );

          if (response.statusCode == 204) {
            print('Event with ID $eventId deleted successfully');
            return true;
          } else {
            print('Failed to delete event with ID $eventId');
            print(response.statusCode.toString());
            print(response.body);
            return false;
          }
        } catch (e) {
          print('Error: $e');
          return false;
        }
      }
    }
    return false; // Return false if token is null or not connected
  }

  @override
  Future<bool> updatetEvent(Evenement event) async {
    bool isConnected = await checkConnection(); // Check connection status

    if (isConnected) {
      String? token = await GetIt.I<FlutterSecureStorage>().read(key: 'access_token');
      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        try {
          final response = await http.put(
            Uri.parse('http://172.19.0.55:8081/evenements/${event.id}'), // Update endpoint with event ID
            encoding: Encoding.getByName('utf-8'),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              'titre': event.titre,
              'type': event.type,
              'category': event.category,
              'dateDebut': event.date_debut,
              'dateFin': event.date_fin,
              'photo': event.photo,
              'position': event.position,
              'localisation': event.localisation,
              'limite': event.limite,
              'description': event.description,
              'lienInscription': event.lienInscription,
              'organisateur': event.organisateur,
            }),
          );

          if (response.statusCode == 200) {
            print('Event updated successfully');
            return true;
          } else {
            print('Failed to update event');
            print(response.statusCode.toString());
            print(response.body);
            return false;
          }
        } catch (e) {
          print('Error: $e');
          return false;
        }
      }
    }
    return false; // Return false if token is null or not connected
  }





}