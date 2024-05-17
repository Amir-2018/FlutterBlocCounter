import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pfechotranasmartvillage/features/reclamation/domain/repository/reclamation_repository.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../domain/model/reclamation.dart';


class ReclamtionRepositoryImpl extends ReclamationRepository {

  @override
  Future<bool> sendReclamation(Reclamation reclamation) async {
    initDependencies() ;
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      final response = await http.post(
        Uri.parse('http://192.168.51.128:8081/reclamations'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body:jsonEncode(<String, dynamic>{
          'sujet': reclamation.sujet,
          'contenu': reclamation.contenu,
          'email': reclamation.email,
          'photo': reclamation.photo,
          'etat': reclamation.etat,
          'isChecked': reclamation.isChecked
        }
      ));
      debugPrint('The response is${reclamation.isChecked}') ;
      if(response.statusCode ==201){
        return true ;
      }
    }
    // Initialise the database
    return false  ;
  }




}