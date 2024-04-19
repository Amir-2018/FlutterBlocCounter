
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_event.dart';

import '../../../../domain/model/point_location.dart';

@immutable
abstract class PositionState {}

class PositionInitialState extends PositionState {}

class PositionSuccessState extends PositionState {
  final DestinationPosition destinationPosition;

  PositionSuccessState(this.destinationPosition);
}

class PositionErrorState extends PositionState {
  final String errorDestinatio;
  PositionErrorState(this.errorDestinatio);
}

class DestinationPosition {
  final String nameDestination;
  final PointLocation pointPosition;

  DestinationPosition(this.nameDestination, this.pointPosition);
}
class RoadState extends PositionState {
  final PointLocation location1;
  final PointLocation location2;

  RoadState(this.location1, this.location2);
}
