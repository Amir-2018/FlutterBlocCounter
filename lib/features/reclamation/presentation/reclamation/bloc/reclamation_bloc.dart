import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../core/database/database_helper.dart';
import '../../../domain/model/reclamation.dart';
import '../../../domain/usecases/insert_actualitie_usecase.dart';

part 'reclamtion_event.dart';
part 'reclamation_state.dart';

class ReclamationBloc extends Bloc<ReclamationEvent, ReclamationState>  {
  InsertReclamationUsecase insertReclamationUsecase ;
  final _stateController = StreamController<ReclamationState>.broadcast();

  Stream<ReclamationState> get stateStream => _stateController.stream;

  @override
  Future<void> close() async {
    //await _stateController.close();
   // return super.close();
  }


  ReclamationBloc(this.insertReclamationUsecase) : super(ReclamationInitial()) {
    on<ReclamationSendEvent>((event, emit) async{
      try {
        final isInserted = await insertReclamationUsecase.call(event.reclamation);
        if(isInserted){
          emit(ReclamationSuccessState()) ;
        }else{
          emit(ReclamationErrorState()) ;
        }
      } catch (e) {
        emit(ReclamationErrorState()) ;
      }
    });



  }
}
