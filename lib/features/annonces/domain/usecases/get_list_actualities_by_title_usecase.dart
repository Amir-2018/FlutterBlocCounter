
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../repository/actualite_repository.dart';


class GetListActualitiesUsecaseByTitle {
  final ActualiteRepository actualiteRepository;

  GetListActualitiesUsecaseByTitle({required this.actualiteRepository});

  Future<List<Actualite>> call(int page,int pageSize,String title) async {
    return await actualiteRepository.getAllActualitesByTitre(page,pageSize,title);
  }
}
