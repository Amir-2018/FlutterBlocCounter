
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../repository/actualite_repository.dart';


class GetListActualitiesOfTodayeUsecase {
  final ActualiteRepository actualiteRepository;

  GetListActualitiesOfTodayeUsecase({required this.actualiteRepository});

  Future<List<Actualite>> call() async {
    return await actualiteRepository.getAllActualitesOfToday();
  }
}
