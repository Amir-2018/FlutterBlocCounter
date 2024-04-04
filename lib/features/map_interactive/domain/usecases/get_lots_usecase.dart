import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/lot.dart';
import '../repository/map_repository.dart';

class GetLotssUseCase {
  final MapRepository mapRepository;

  GetLotssUseCase({required this.mapRepository});

  Future<List<Lot>> call() async {
    return await mapRepository.getLots();
  }
}
