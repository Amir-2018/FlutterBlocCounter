
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../repository/actualite_repository.dart';


class InsertActualityUsecase {
  final ActualiteRepository actualiteRepository;

  InsertActualityUsecase({required this.actualiteRepository});

  Future<bool> call(Actualite act) async {
    return await actualiteRepository.insertActualies(act);
  }
}
