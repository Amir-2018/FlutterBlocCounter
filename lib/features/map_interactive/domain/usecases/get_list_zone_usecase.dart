import 'dart:async';

import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/zone.dart';

import '../repository/map_repository.dart';

class GetZoneBounderiesUseCase {
  final MapRepository mapRepository;

  GetZoneBounderiesUseCase({required this.mapRepository});

  Future<Zone> call() async {
    return await mapRepository.getZone();
  }
}
