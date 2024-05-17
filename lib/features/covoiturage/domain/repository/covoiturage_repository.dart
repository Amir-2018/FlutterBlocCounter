import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';

import '../model/covoiturage_model.dart';


abstract class CovoiturageRepository {
  Future<List<CovoiturageModel>> getListCovoiturages(int page,int pageSize);
  Future<bool> insertCovoiturage(CovoiturageModel cov);
  Future<List<CovoiturageModel>> getAllCovoituragesByTitre(int page,int pageSize,String title);



}
