import 'package:pfechotranasmartvillage/features/reclamation/domain/model/reclamation.dart';


abstract class ReclamationRepository {
  Future<bool> sendReclamation(Reclamation reclamation);
}
