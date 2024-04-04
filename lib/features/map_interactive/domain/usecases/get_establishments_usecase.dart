import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/establishment.dart';
import '../repository/map_repository.dart';

class GetEstablishmentsUseCase {
  final MapRepository mapRepository;

  GetEstablishmentsUseCase({required this.mapRepository});

  Future<List<Establishment>> call() async {
    return await mapRepository.getEstablishments();
  }
}
