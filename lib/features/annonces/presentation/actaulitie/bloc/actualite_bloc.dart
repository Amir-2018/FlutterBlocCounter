import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../core/database/database_helper.dart';
import '../../../data/implementation/actualite_repo_impl.dart';
import '../../../domain/model/actualite.dart';
import '../../../domain/repository/actualite_repository.dart';
import '../../../domain/usecases/get_actualities_of_today_usecase.dart';
import '../../../domain/usecases/get_list_actualities_by_title_usecase.dart';
import '../../../domain/usecases/get_list_actualities_usecase.dart';
import '../../../domain/usecases/insert_actualitie_usecase.dart';
import '../../list_annonce/list_annonce.dart';

part 'actualite_event.dart';
part 'actualite_state.dart';

class ActualiteBloc extends Bloc<ActualiteEvent, ActualiteState>  {
  InsertActualityUsecase insertActualityUsecase ;
  GetListActualitiesUsecase getListActualitiesUsecase ;
  GetListActualitiesUsecaseByTitle getActualitiesByTitle ;
  GetListActualitiesOfTodayeUsecase getListActualitiesOfTodayeUsecase ;
  final _stateController = StreamController<ActualiteState>.broadcast();

  Stream<ActualiteState> get stateStream => _stateController.stream;

  @override
  Future<void> close() async {
    // await _stateController.close();
    //return super.close();
  }

  Future<void> _onGetAllActualites(
      ActualiteGetAllEvent event,
      Emitter<ActualiteState> emit,
      ) async {
    try {
      emit(ActualiteLoadingState());
      debugPrint('The function will get the result ') ;

      List<Actualite> listActualitie = await getListActualitiesUsecase.call(event.page,event.pageSize);

        ListAnnoces.actulitesList.addAll(listActualitie) ;

        if(listActualitie.isEmpty && event.page==0){
        emit(ActualiteEmptyState('empty')) ;
      }
      else{
        emit(ListActualiteSuccessMessageState(listActualitie));

      }
      debugPrint('Bloc talk ${listActualitie.toString()}') ;



    } catch (e) {
      emit(ActualiteErrorState("Une erreur s'est produite: $e"));
    }
  }
  ActualiteBloc(this.insertActualityUsecase,this.getListActualitiesUsecase,this.getActualitiesByTitle,this.getListActualitiesOfTodayeUsecase) : super(ActualiteInitial()) {
    on<ActualiteSaveEvent>((event, emit) async{
        try {
          debugPrint('Event has come ${event.actualite}');

            DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
            await databaseHelper.initializeDatabase();
            final isInserted = await insertActualityUsecase.call(event.actualite);

            if(isInserted){
              emit(ActualiteSuccessMessageState('Inserted with success'));

            }else{
              emit(ActualiteErrorState('Actualite does not be inserted '));
            }


        } catch (e) {
          debugPrint('Exceptionsssss : $e');
        }

    });
    on<ActualiteGetAllEvent>((event, emit) async{
      await _onGetAllActualites(event,emit);
    });
    on<GetActualitiesByTitle>((event, emit) async{
      try {


          DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

          await databaseHelper.initializeDatabase();

          List<Actualite> listActualitie = await getActualitiesByTitle.call(event.page,event.pageSize,event.title);

          debugPrint(listActualitie.toString()) ;
          emit(FilterListActualiteSuccessMessageState(listActualitie));

      } catch (e) {
        emit(ActualiteErrorState('Actualite has not be inserted '));
      }
    });
    on<GetActualitiesByTitleForservicesPageEvent>((event, emit) async{
      try {

        print('The event has come') ;
        DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();

        await databaseHelper.initializeDatabase();

        List<Actualite> listActualitie = await getActualitiesByTitle.call(event.page,event.pageSize,event.title);
        emit(FilterListActualiteSuccessMessageForServicesState(listActualitie));

      } catch (e) {
        emit(ActualiteErrorState('Actualite does not be inserted '));
      }
    });
    on<MakeTexFieldEmptyEvent>((event, emit) async{
      try {
        emit(ActualiteMakeTexFieldEmptyState());
      } catch (e) {
        debugPrint('Cannot emit');
      }
    });

    on<GetActualitesOfTodays>((event, emit) async {
      try {
        emit(ActualiteLoadingServicesState()); // Emit loading state

        List<Actualite> listActualitie = await getListActualitiesOfTodayeUsecase.call();
        emit(ListActualiteSuccessOfTodaye(listActualitie));
      } catch (e) {
        emit(ActualiteErrorState('Error fetching actualites')); // Emit error state
        debugPrint('Cannot emit');
      }
    });

  }
}
