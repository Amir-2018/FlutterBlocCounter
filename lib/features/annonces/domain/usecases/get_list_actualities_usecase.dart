
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../repository/actualite_repository.dart';


class GetListActualitiesUsecase {
  final ActualiteRepository actualiteRepository;

  GetListActualitiesUsecase({required this.actualiteRepository});

  Future<List<Actualite>> call(int page,int pageSize) async {
    return await actualiteRepository.getListActualies(page,pageSize);
  }
}
