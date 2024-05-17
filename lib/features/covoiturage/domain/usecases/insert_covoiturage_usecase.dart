
import 'package:pfechotranasmartvillage/features/covoiturage/domain/model/covoiturage_model.dart';
import '../repository/covoiturage_repository.dart';

class InsertCovoiturageUsecase {
  final CovoiturageRepository covoiturageRepository;

  InsertCovoiturageUsecase ({required this.covoiturageRepository});

  Future<bool> call(CovoiturageModel cov) async {
    return await covoiturageRepository.insertCovoiturage(cov);
  }
}
