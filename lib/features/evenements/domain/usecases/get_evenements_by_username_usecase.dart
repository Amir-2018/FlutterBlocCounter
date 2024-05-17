
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';

import '../repository/evenement_repository.dart';


class GestEvenementsByUsernameUsecase {
  final EvenementRepository evenementRepository;

  GestEvenementsByUsernameUsecase({required this.evenementRepository});

  Future<List<Evenement>> call(String username) async {
    return await evenementRepository.getEventsByUsername(username);
  }
}
