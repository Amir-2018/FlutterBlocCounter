import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../domain/model/event.dart';
import '../../../domain/usecases/delete_evenement_usecase.dart';
import '../../../domain/usecases/get_evenements_by_username_usecase.dart';
import '../../../domain/usecases/insert_evenement_usecase.dart';
import '../../../domain/usecases/update_evenement_usecase.dart';

part 'evenement_event.dart';
part 'evenement_state.dart';

class EvenementBloc extends Bloc<EvenementEvent, EvenementState>  {

  InsertEvenementUsecase insertEventUsecase ;
  GestEvenementsByUsernameUsecase  gestEvenementsByUsernameUsecase ;
  @override  DeleteEvenementUsecase deleteEvenementUsecase ;
  @override  UpdateEvenementUsecase updateEvenementUsecase ;


  Future<void> close() async {
  }

  List<Evenement> evenementList = const [

  ] ;

  EvenementBloc(this.insertEventUsecase,this.gestEvenementsByUsernameUsecase ,this.deleteEvenementUsecase,this.updateEvenementUsecase) : super(EvenementInitial()) {
    on<EvenementGetAllEvent>((event, emit) async{
      return emit(ListEvenementsSuccessMessageState(evenementList)) ;

    });

    on<SendPositionEvent>((event, emit) async{
      return emit(SendPositionState()) ;
    });

    on<EvenementSaveEvent>((event, emit) async{
      try {
        final isInserted = await insertEventUsecase.call(event.evenement);

        if(isInserted){
          emit(EnevtSuccessState('SucessInserted')) ;
        }else{
          emit(EnevtErrorState("Echech d'ajout")) ;
        }
      } catch (e) {
        emit(EnevtErrorState("Echech d'ajout")) ;
      }
    });

    on<EvenementCrudGetAllEvent>((event, emit) async{
      try {
        List<Evenement> listEvenements = await gestEvenementsByUsernameUsecase.call(event.username);
        print('I getted ${listEvenements.toString()}') ;
        return(emit(EvenementCrudSuccessMesgsaeState(listEvenements)) );
      } catch (e) {
        emit(EvenementErrorCrudState("Echech d'ajout")) ;
      }
    });

    on<EvenementCrudDeleteEvent>((event, emit) async{
      print('Event has come') ;
      try {
        final isDeleted = await deleteEvenementUsecase.call(event.id);
        if(isDeleted){
          return(emit(EvenementSuccessDeleteState('deleted with success')) );
        }
      } catch (e) {
        emit(EvenementErrorCrudState("Echech d'ajout")) ;
      }
    });

    on<EvenementUpdateEvent>((event, emit) async{
      print('Event has come') ;
      try {
        final isUpdated = await updateEvenementUsecase.call(event.evenement);
        if(isUpdated){
          return(emit(EvenementSuccessUpdateState('deleted with success')) );
        }
      } catch (e) {
        emit(EvenementErrorUpdateState("Echech d'ajout")) ;
      }
    });

  }

}
