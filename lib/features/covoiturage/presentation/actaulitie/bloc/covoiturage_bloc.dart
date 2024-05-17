import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../core/database/database_helper.dart';
import '../../../domain/model/covoiturage_model.dart';
import '../../../domain/usecases/get_list_covoiturages_by_title_usecase.dart';
import '../../../domain/usecases/get_list_covoiturages_usecase.dart';
import '../../../domain/usecases/insert_covoiturage_usecase.dart';
import '../../list_covoiturages/list_covoiturage.dart';

part 'covoiturage_event.dart';
part 'covoiturage_state.dart';

class CovoiturageBloc extends Bloc<CovoiturageEvent, CovoiturageState>  {
  InsertCovoiturageUsecase insertCovoiturageUsecase ;
  GetListCovoituragesUsecase getListCovoituragesUsecase ;
  GetListCovoituragesUsecaseByTitle getListCovoituragesUsecaseByTitle ;
  final _stateController = StreamController<CovoiturageState>.broadcast();

  Stream<CovoiturageState> get stateStream => _stateController.stream;

  @override
  Future<void> close() async {
    //await _stateController.close();
    //return super.close();
  }

  Future<void> _onGetAllCovoiturages(
      CovoiturageGetAllEvent event,
      Emitter<CovoiturageState> emit,
      ) async {
    try {
      emit(CovoiturageLoadingState());
      debugPrint('The function will get the result ') ;

      List<CovoiturageModel> listCovoiturages = await getListCovoituragesUsecase.call(event.page,event.pageSize);

      ListCovoiturages.covoituragesList.addAll(listCovoiturages) ;
        print('evente page = ${event.page}') ;
        if(listCovoiturages.isEmpty && event.page==0){
        emit(CovoiturageEmptyState('empty')) ;
      }
      else{
        emit(ListCovoituragesSuccessMessageState(listCovoiturages));

      }
      debugPrint('Bloc talk ${listCovoiturages.toString()}') ;



    } catch (e) {
      emit(CovoiturageErrorState("Une erreur s'est produite: $e"));
    }
  }
  CovoiturageBloc(this.insertCovoiturageUsecase,this.getListCovoituragesUsecase,this.getListCovoituragesUsecaseByTitle) : super(CovoiturageInitial()) {
    on<CovoiturageSaveEvent>((event, emit) async{
        try {

            DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
            await databaseHelper.initializeDatabase();
            final isInserted = await insertCovoiturageUsecase.call(event.covoiturageModel);

            if(isInserted){
              emit(CovoiturageSuccessMessageState('Inserted with success'));

            }else{
              emit(CovoiturageErrorState('Covoiturage does not be inserted '));
            }

        } catch (e) {
          debugPrint('Exceptionsssss : $e');
        }
    });
    on<CovoiturageGetAllEvent>((event, emit) async{
      debugPrint('Je event') ;
      await _onGetAllCovoiturages(event,emit);
    });
    on<GetCovoituragesByTitleEvent>((event, emit) async{
      try {
          List<CovoiturageModel> listCovoiturages = await getListCovoituragesUsecaseByTitle.call(event.page,event.pageSize,event.title);
          emit(FilterListCovoituragesSuccessMessageState(listCovoiturages));
      } catch (e) {
        emit(CovoiturageErrorState('Actualite does not be inserted '));
      }
    });
  }
}
