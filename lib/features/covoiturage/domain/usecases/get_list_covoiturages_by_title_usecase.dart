
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/domain/model/covoiturage_model.dart';

import '../repository/covoiturage_repository.dart';


class GetListCovoituragesUsecaseByTitle {
  final CovoiturageRepository covoiturageRepository;

  GetListCovoituragesUsecaseByTitle({required this.covoiturageRepository});

  Future<List<CovoiturageModel>> call(int page,int pageSize,String title) async {
    return await covoiturageRepository.getAllCovoituragesByTitre(page,pageSize,title);
  }
}
