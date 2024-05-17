import 'package:pfechotranasmartvillage/features/venteAchat/domain/model/vente.dart';
import '../repository/vente_repository.dart';


class InsertVenteUsecase {
  final VenteRepository venteRepository;

  InsertVenteUsecase({required this.venteRepository});

  Future<bool> call(Vente vt) async {
    return await venteRepository.insertVente(vt);
  }
}
