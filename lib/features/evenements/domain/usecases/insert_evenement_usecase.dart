
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';

import '../repository/evenement_repository.dart';


class InsertEvenementUsecase {
  final EvenementRepository evenementRepository;

  InsertEvenementUsecase({required this.evenementRepository});

  Future<bool> call(Evenement evt) async {
    return await evenementRepository.insertEvent(evt);
  }
}
