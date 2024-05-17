import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';


abstract class EvenementRepository {
  Future<bool> insertEvent(Evenement event);
  Future<List<Evenement>> getEventsByUsername(String username);
  Future<bool> deleteEvent(int id);

  Future<bool> updatetEvent(Evenement event);



}
