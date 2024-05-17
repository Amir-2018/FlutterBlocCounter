import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/model/covoiturage_model.dart';
import '../../domain/repository/covoiturage_repository.dart';
import 'covoiturage_repo_impl_functions.dart';


class CovoiturageRepositoryImpl extends CovoiturageRepository {

  @override
  Future<bool> insertCovoiturage(CovoiturageModel cov) async {
    initDependencies() ;
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      final response = await http.post(
          Uri.parse('http://172.19.0.55:8081/annonces/covoiturage'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(<String, dynamic>{
            'depart': cov.depart,
            'destination': cov.destination,
            'temps_depart': cov.temps_depart,
            'nb_personnes': cov.nb_personnes,
            'titre': cov.titre,
            'date': cov.date,
            'contact': cov.contact,
            'type': cov.type,
            'photo': '${cov.photo}',
            'cotisation': cov.cotisation,
            'confirmed': cov.confirmed,
            'description': cov.description,

          }
          ));
      debugPrint('The photo is data:image/png;base64,${cov.photo}') ;
      if(response.statusCode ==201){
        return true ;
      }
    }
    return false  ;
  }

  @override
  Future<List<CovoiturageModel>> getAllCovoituragesByTitre(int page, int pageSize, String title) async {
    initDependencies() ;

    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

    await databaseHelper.initializeDatabase();

    List<CovoiturageModel> listCovoiturages = await databaseHelper.getAllCovoituragesByTitre(page,pageSize,title) ;
    return listCovoiturages ;
  }

  @override
  Future<List<CovoiturageModel>> getListCovoiturages(int page, int pageSize) async {
    final covoiturageRepository = getIt<CovoiturageRepositoryImplFunctions>();

    initDependencies();
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();
    bool isConnected = await checkConnection();
    List<CovoiturageModel> covoituragesList = [];
    if (isConnected) {
      print('I will send it');
      final response = await http.get(
        Uri.parse('http://172.19.0.55:8081/annonces/covoiturage'),
      );
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonListActualities = jsonDecode(response.body);
        for (var item in jsonListActualities['data']) {
          CovoiturageModel covoiturage = CovoiturageModel.fromJson(item);
          debugPrint(item.toString()) ;
          covoituragesList.add(covoiturage);
        }
        await databaseHelper.deleteAllCovoiturages() ;
        bool isListInserted = await databaseHelper.insertCovoiturages(covoituragesList);
        if(isListInserted){
          List<CovoiturageModel> listCovoiturages = await covoiturageRepository.getCovoituragesAndTitles(page,pageSize,databaseHelper) ;
          return listCovoiturages;
        }else{
          print('Database does not been inserted') ;
        }

      } else {
        List<CovoiturageModel> listCovoiturages = await covoiturageRepository.getCovoituragesAndTitles(page,pageSize,databaseHelper) ;
        return listCovoiturages;
      }
      return [];
    }else{

      List<CovoiturageModel> listCovoiturages = await covoiturageRepository.getCovoituragesAndTitles(page,pageSize,databaseHelper) ;
      return listCovoiturages;

    }
  }

}