import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/domain/usecases/get_list_ventes_usecase.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/domain/usecases/get_list_ventes_by_title_usecase.dart';

import '../../../../../core/database/database_helper.dart';
import '../../../domain/model/vente.dart';
import '../../../domain/usecases/insert_vente_usecase.dart';
import '../../list_ventes/list_ventes.dart';
import '../vente_widget.dart';

part 'vente_event.dart';
part 'vente_state.dart';

class VenteBloc extends Bloc<VenteEvent, VenteState>  {
  InsertVenteUsecase insertVenteUsecase ;
  GetListVentesUsecase getListVentesUsecase ;
  GetListVentesByTitleUsecase getVentesByTitleusecase ;
  final _stateController = StreamController<VenteState>.broadcast();

  Stream<VenteState> get stateStream => _stateController.stream;

  @override
  Future<void> close() async {
    //await _stateController.close();
    //return super.close();
  }

  Future<void> _onGetAllActualites(
      VenteGetAllEvent event,
      Emitter<VenteState> emit,
      ) async {
    try {
      emit(VenteLoadingState());
      List<Vente> listVentes = await getListVentesUsecase.call(event.page,event.pageSize);
      if(listVentes.length<=event.pageSize){
        debugPrint('C bon') ;
      }
      if(listVentes.length==0 && event.page==0){
        debugPrint('I will emit empty state') ;
        emit(VenteEmptyState('empty')) ;}else{
        ListVentes.ventListes.addAll(listVentes)  ;

        emit(ListVenteSuccessMessageState(listVentes));

      }
      debugPrint('BlocVente say $listVentes') ;

    } catch (e) {
      emit(VenteErrorState("Une erreur s'est produite: $e"));
    }
  }
  VenteBloc(this.insertVenteUsecase,this.getListVentesUsecase,this.getVentesByTitleusecase) : super(VenteInitial()) {

    on<VenteGetAllEvent>((event, emit) async{
     //ListAnnoces.page  += 1 ;
      await _onGetAllActualites(event,emit);
    });
    on<GetVentesByTitle>((event, emit) async{
      try {
          DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

          await databaseHelper.initializeDatabase();

          List<Vente> listVentes = await getVentesByTitleusecase.call(event.page,event.pageSize,event.title);
          if(listVentes.isEmpty && event.page==0){
            emit(VenteEmptyState('empty')) ;}
          if(listVentes.isNotEmpty){
            emit(FilterListVenteSuccessMessageState(listVentes));

          }

      } catch (e) {
        emit(VenteErrorState('Actualite does not be inserted '));
      }
    });

    on<VenteSaveEvent>((event, emit) async{
      try {
        bool isVenteinsertes = await insertVenteUsecase.call(event.vente);
        if(isVenteinsertes){
          print('Vente added with success') ;
          emit(VenteSuccessMessageState('Added with success ...'));
        }else{
          print('Vente Not added') ;
          emit(VenteErrorState('Not added'));

        }



      } catch (e) {
        emit(VenteErrorState('Not added'));
      }

    });

    on<GetAchaOuAchattEventOnly>((event, emit) async{
      try {

        DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

        await databaseHelper.initializeDatabase();
        if(event.tableName=='vente'){
          List<Vente> listesVentesOuAchat = await databaseHelper.getAllVentesOuAchats(event.page, event.pageSize,0) ;
          if(listesVentesOuAchat.isNotEmpty){
            emit(FilterListVenteSuccessMessageVentesouAchatState(listesVentesOuAchat)) ;
          }
        }else if(event.tableName=='achat'){
          List<Vente> listesVentesOuAchat = await databaseHelper.getAllVentesOuAchats(event.page, event.pageSize,1) ;
          if(listesVentesOuAchat.isNotEmpty){
            emit(FilterListVenteSuccessMessageVentesouAchatState(listesVentesOuAchat)) ;

          }
        }else{
          debugPrint('Failure to insert') ;
          emit(VenteErrorState('Actualite does not be inserted '));
        }

      } catch (e) {
        debugPrint('Exception : $e');
      }

    });
  }
}
