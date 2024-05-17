import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/usecases/get_lots_usecase.dart';

import '../../../../domain/model/lot.dart';

part 'lots_event.dart';
part 'lots_state.dart';

class LotsBloc extends Bloc<LotsEvent, LotsState> {
  GetLotssUseCase getLotsUseCase;

  LotsBloc(this.getLotsUseCase) : super(LotInitialState()) {
    on<GetLotEvent>((event, emit) async{
      final List<Lot> lots = await getLotsUseCase.call();
      emit(LotlistSuccessState(
          lots
      ));
    });


  }
}
