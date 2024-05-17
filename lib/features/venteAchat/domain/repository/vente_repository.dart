import 'package:pfechotranasmartvillage/features/venteAchat/domain/model/vente.dart';


abstract class VenteRepository {
  Future<List<Vente>> getListVentes(int page,int pageSize);
  Future<bool> insertVente(Vente vente);
  Future<List<Vente>> getAllVentesByTitre(int page,int pageSize,String title);
  Future<List<Vente>> getVentesouAchats(int page,int pageSize,String tableName);




}
