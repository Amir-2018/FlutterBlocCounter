import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/bloc/zone_event.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/bloc/zone_state.dart';
import '../domain/usecases/get_list_zone_usecase.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final GetZoneBounderiesUseCase getZoneBounderiesUseCase;
  ZoneBloc(
      this.getZoneBounderiesUseCase,
      ) : super(ZoneInitialState()) {
    on<GetZoneEvent>((event, emit) async {
      try {
        debugPrint('I will bring the map');
        final  zone = await getZoneBounderiesUseCase.call();
        debugPrint('User is ${zone.nom}');
        emit(ZoneSuccessState(zone));
      } catch (e) {
        debugPrint('Erro with signup $e');
        emit(ZoneErrorState("Zone peut pas etre téléchargé "));
      }
    });
  }
}
