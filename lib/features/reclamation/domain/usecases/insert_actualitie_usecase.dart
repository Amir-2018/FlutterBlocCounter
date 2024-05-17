import 'package:pfechotranasmartvillage/features/reclamation/domain/model/reclamation.dart';
import '../repository/reclamation_repository.dart';


class InsertReclamationUsecase {
  final ReclamationRepository reclamationRepository;

  InsertReclamationUsecase({required this.reclamationRepository});

  Future<bool> call(Reclamation reclamation) async {
    return await reclamationRepository.sendReclamation(reclamation);
  }
}
