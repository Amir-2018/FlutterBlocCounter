
import 'package:pfechotranasmartvillage/features/covoiturage/domain/model/covoiturage_model.dart';

import '../repository/covoiturage_repository.dart';


class GetListCovoituragesUsecase {
  final CovoiturageRepository covoiturageRepository;

  GetListCovoituragesUsecase({required this.covoiturageRepository});

  Future<List<CovoiturageModel>> call(int page,int pageSize) async {
    return await covoiturageRepository.getListCovoiturages(page,pageSize);
  }
}
