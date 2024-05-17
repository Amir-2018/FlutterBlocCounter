import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:http/http.dart' as http;
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/repository/actualite_repository.dart';
import '../../presentation/list_annonce/list_annonce.dart';


class ActualiteRepositoryImpl extends ActualiteRepository {

  @override
  Future<List<Actualite>> getListActualies(int page, int pageSize) async {
    initDependencies();

    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

    await databaseHelper.initializeDatabase();

    List<Actualite> listActualites = await databaseHelper.getAllActualites(page, pageSize);


    List<String> titles = await databaseHelper.getAllActualiteTitles();

    ListAnnoces.page += 1  ;

    AutocompleteBasicExample.options.addAll(titles.toSet());


    return listActualites;

  }


  @override
  Future<bool> insertActualies(Actualite act) async {
      debugPrint('I will insert $act') ;
    initDependencies() ;
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      debugPrint('Connected and actualite is $act') ;
      final response = await http.post(
        Uri.parse('http://172.19.0.55:8081/annonces'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body:jsonEncode(<String, dynamic>{
          'titre': act.titre,
          'type': act.type,
          'description': act.description,
          'photo': act.photo,
          'contact': act.contact,
          'date': act.date
        }
      ));
      debugPrint('The response is${response.statusCode}') ;
      if(response.statusCode ==201){
        return true ;
      }
    }
    // Initialise the database
    return false  ;
  }

  @override
  Future<List<Actualite>> getAllActualitesByTitre(int page,int pageSize,String title) async {
    initDependencies() ;

    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

    await databaseHelper.initializeDatabase();
    //await databaseHelper.deleteAllActualites();
    if (ListAnnoces.searchList.isNotEmpty) {
      ListAnnoces.searchList.clear();
    }

    List<Actualite> listActualities = await databaseHelper.getAllActualitesByTitre(page,pageSize,title) ;

    return listActualities ;
  }

  @override
  Future<List<Actualite>> getAllActualitesOfToday() async {
    initDependencies();
    // Initialise database connection
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();
    // Verify internet connection
    bool isConnected = await checkConnection();
    // The list of octualities
    List<Actualite> actualitesList = [];
    // await databaseHelper.deleteAllActualites() ;
    // Sending get request
    if (isConnected) {
      print('I will send it');
      final response = await http.get(
        Uri.parse('http://172.19.0.55:8081/annonces'),
      );

      if (response.statusCode == 200) {
        //print(response.body.toString());
        //Insert response in database
        var jsonListActualities = jsonDecode(response.body);
        // Loop the list and convert every element to Actualite Object
        for (var item in jsonListActualities['data']) {
          //debugPrint('The item is $item');
          Actualite actualite = Actualite.fromJson(item);
          debugPrint(item.toString()) ;
          actualitesList.add(actualite);
        }
        await databaseHelper.deleteAllActualites() ;
        bool isListInserted = await databaseHelper.insertActualites(
            actualitesList);
        if(isListInserted){
          List<Actualite> listActualites = await databaseHelper.getAllActualitesOfToday();


          List<String> titles = await databaseHelper.getAllActualiteTitles();
          ListAnnoces.page += 1  ;

          AutocompleteBasicExample.options.addAll(titles.toSet());
          return listActualites;
        }else{
          print('Database does not been inserted') ;
        }

      } else {
        List<Actualite> listActualites = await databaseHelper.getAllActualitesOfToday() ;
        List<String> titles = await databaseHelper.getAllActualiteTitles();

        AutocompleteBasicExample.options.addAll(titles.toSet());
        ListAnnoces.page += 1  ;

        return listActualites;
      }
      return [];
    }else{
      debugPrint('Offline mode') ;

      List<Actualite> listActualites = await databaseHelper.getAllActualitesOfToday();
      List<String> titles = await databaseHelper.getAllActualiteTitles();
      AutocompleteBasicExample.options.addAll(titles.toSet());
      ListAnnoces.page += 1  ;
      debugPrint('The liset is $listActualites') ;
      return listActualites;

    }  }

}