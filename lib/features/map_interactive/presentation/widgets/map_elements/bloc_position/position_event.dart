
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_state.dart';

import '../../../../domain/model/point_location.dart';


@immutable
abstract class PositionEvent {}

class GetPositionEvent extends PositionEvent {
  final DestinationPosition destinationData;

  GetPositionEvent({required this.destinationData});
}

class SendLocationsEvent extends PositionEvent {
  final PointLocation location1;
  final PointLocation location2;
  SendLocationsEvent({required this.location1, required this.location2});
}







