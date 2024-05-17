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
      print('I will get the zone') ;
      try {//
        debugPrint('I will bring the zone');
        final  zone = await getZoneBounderiesUseCase.call();
        debugPrint('zone amir is ${zone.bordures}');

        emit(ZoneSuccessState(zone));
      } catch (e) {
        debugPrint('Exception with map bringing $e');
        emit(ZoneErrorState("Zone peut pas etre téléchargé "));
      }
    });
  }
}
