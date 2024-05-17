
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../model/vente.dart';
import '../repository/vente_repository.dart';


class GetListVentesUsecase {
  final VenteRepository venteRepository;

  GetListVentesUsecase({required this.venteRepository});

  Future<List<Vente>> call(int page,int pageSize) async {
    return await venteRepository.getListVentes(page,pageSize);
  }
}
