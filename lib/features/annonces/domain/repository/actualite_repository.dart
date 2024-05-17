import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';


abstract class ActualiteRepository {
  Future<List<Actualite>> getListActualies(int page,int pageSize);
  Future<bool> insertActualies(Actualite act);
  Future<List<Actualite>> getAllActualitesByTitre(int page,int pageSize,String title);
  Future<List<Actualite>> getAllActualitesOfToday();




}
