import 'dart:async';

 import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';


abstract class MapRepository {
  Future<List<Lot>> getLots();
  Future<List<Establishment>> getEstablishments();
  Future<Zone> getZone();





}
