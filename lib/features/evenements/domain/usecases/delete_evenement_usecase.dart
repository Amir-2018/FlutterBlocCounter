
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';

import '../repository/evenement_repository.dart';


class DeleteEvenementUsecase {
  final EvenementRepository evenementRepository;

  DeleteEvenementUsecase({required this.evenementRepository});

  Future<bool> call(int id) async {
    return await evenementRepository.deleteEvent(id);
  }
}
