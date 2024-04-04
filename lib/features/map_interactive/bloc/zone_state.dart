import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';

@immutable
abstract class ZoneState {}

class ZoneInitialState extends ZoneState {}

class ZoneSuccessState extends ZoneState {
  final Zone zone;
  ZoneSuccessState(this.zone);
}

class ZoneErrorState extends ZoneState {
  final String errormessage;
  ZoneErrorState(this.errormessage);
}

class ZoneNullState extends ZoneState {
  final String zonenullmessage;
  ZoneNullState(this.zonenullmessage);
}