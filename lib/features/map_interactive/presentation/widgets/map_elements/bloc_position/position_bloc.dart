import 'package:bloc/bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_event.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_state.dart';
import 'package:latlong2/latlong.dart';
import 'map_home_page/map_home_page.dart';
import 'map_home_page/map_home_page_controller.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitialState()) {
    on<GetPositionEvent>((event, emit) {
      emit(PositionSuccessState(
        DestinationPosition(
          event.destinationData.nameDestination,
          event.destinationData.pointPosition,
        ),
      ));
    });

    on<SendLocationsEvent>((event, emit) {
      final location1 = event.location1;
      final location2 = event.location2;
      emit(RoadState(location1, location2));

      //zone.clear() ;

    });

  }
}