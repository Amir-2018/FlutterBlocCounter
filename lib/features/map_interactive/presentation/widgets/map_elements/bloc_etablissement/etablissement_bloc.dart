import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';

import '../../../../../../core/database/database_helper.dart';
import '../../../../data/implementation/map_repository_impl.dart';
import '../../../../domain/usecases/get_establishments_usecase.dart';

part 'etablissement_event.dart';
part 'etablissement_state.dart';

class EstablishmentBloc extends Bloc<EtablissementEvent, EtablissementState> {
  GetEstablishmentsUseCase getEstablishmentsUseCase;

  EstablishmentBloc(this.getEstablishmentsUseCase) : super(EtablissementInitialState()) {
    on<GetEtablissementEvent>((event, emit) async{
      final List<Establishment> etablissements = await getEstablishmentsUseCase.call();
       emit(EtablissementSuccessState(
           etablissements
      ));
    });

    on<SendEtablissementLocalEvent>((event, emit) async{
      DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
      await databaseHelper.initializeDatabase();
      List<Establishment> etablissements = await GetIt.I<MapRepositoryImpl>().getEstablishmentsFromDatabase(databaseHelper);
      return emit(EtablissementSuccessLocalState(etablissements)) ;
    });

    on<SendEtablissementPoslEvent>((event, emit) async{
      return emit(PositionNomEtablisseentState(event.etablissementPos)) ;
    });


  }
}

