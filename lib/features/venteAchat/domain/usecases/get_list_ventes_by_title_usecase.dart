
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../model/vente.dart';
import '../repository/vente_repository.dart';


class GetListVentesByTitleUsecase {
  final VenteRepository venteRepository;

  GetListVentesByTitleUsecase({required this.venteRepository});

  Future<List<Vente>> call(int page,int pageSize,String title) async {
    return await venteRepository.getAllVentesByTitre(page,pageSize,title);
  }
}
