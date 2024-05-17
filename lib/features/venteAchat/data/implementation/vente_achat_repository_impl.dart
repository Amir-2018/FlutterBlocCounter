import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';
import 'package:http/http.dart' as http;
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/model/vente.dart';
import '../../domain/repository/vente_repository.dart';
import '../../presentation/vente/vente_search_field_all.dart';
import '../../presentation/vente/vente_widget.dart';

class VenteAchatRepositoryImpl extends VenteRepository {

  @override
  Future<List<Vente>> getListVentes(int page, int pageSize) async {
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();

    List<Vente> listVentes = [] ;
    initDependencies() ;
    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      final response = await http.get(
        Uri.parse('http://172.19.0.55:8081/annonces/achat-vente'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        var jsonDataVentes = jsonDecode(response.body);
        //debugPrint(jsonDataVentes['data'].toString());

        for (var item in jsonDataVentes['data']) {
          //debugPrint('The item is $item');
          Vente vente = Vente.fromJson(item);
          listVentes.add(vente) ;
          debugPrint('Item map ${vente.toMap()}') ;
        }
        await databaseHelper.deleteAllVentes() ;
        bool isVentesInserted = await databaseHelper.insertVentes(listVentes) ;

        if(isVentesInserted){
          List<Vente> ventesFromLocal = await databaseHelper.getAllVentes(page, pageSize) ;
          List<String> titles = await databaseHelper.getAllVentesByTitres();

          VenteSearchField.options.addAll(titles.toSet());
          debugPrint('List from local $ventesFromLocal') ;

          ListVentes.page += 1  ;

          return ventesFromLocal ;
        }
      }else{
        List<String> titles = await databaseHelper.getAllVentesByTitres();
        VenteSearchField.options.addAll(titles.toSet());
        List<Vente> ventesFromLocal = await databaseHelper.getAllVentes(page, pageSize) ;
        ListVentes.page += 1  ;

        return ventesFromLocal ;
      }


    }else{
      List<String> titles = await databaseHelper.getAllVentesByTitres();
      VenteSearchField.options.addAll(titles.toSet());
      List<Vente> ventesFromLocal = await databaseHelper.getAllVentes(page, pageSize) ;
      ListVentes.page += 1  ;

      return ventesFromLocal ;
    }


    ListVentes.ventListes.addAll(listVentes) ; 
    return listVentes ;
  }

  @override
  Future<List<Vente>> getAllVentesByTitre(int page, int pageSize, String title) async {
      initDependencies() ;
      print('page is $page') ;
      DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

      await databaseHelper.initializeDatabase();

      List<Vente> listVentes = await databaseHelper.getAllVentesByTitre(page,pageSize,title) ;
       debugPrint('La liste des ventes est $listVentes  $title') ;
       return listVentes ;
  }

  @override
  Future<bool> insertVente(Vente vente) async {
    initDependencies() ;

    final functions = GetIt.I.get<Functions>();

    bool isConnected = await checkConnection(); // Vérifier la connexion

    if (isConnected) {
      final response = await http.post(
          Uri.parse('http://172.19.0.55:8081/annonces/achat-vente'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(<String, dynamic>{
            'titre': vente.titre,
            'prix': vente.prix,
            'objet': vente.objet,
            'quantite': vente.quantite,
            'photo': vente.photo!,
            'date': vente.date,
            'contact': vente.contact,
            'type': vente.type,
            'description': vente.description,
            'annonceAchat' : VenteWidget.typeAnnonce == 'achat'
          }));
      print('The photo is ${vente.photo}') ;
      if(response.statusCode ==201){
        return true ;
      }
    }
    print('False my freind ') ;

    return false  ;
  }

  @override
  Future<List<Vente>> getVentesouAchats(int page, int pageSize, String tableName) {
    throw UnimplementedError();
  }

}