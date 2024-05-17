part of 'vente_bloc.dart';

@immutable
abstract class VenteEvent {}


class VenteEventInitial extends VenteEvent {}



class GetAchaOuAchattEventOnly extends VenteEvent {
  final int page;
  final int pageSize;
  final String tableName;
  GetAchaOuAchattEventOnly(this.page,this.pageSize,this.tableName) ;
}

class VenteSaveEvent extends VenteEvent {
  final Vente vente;
  VenteSaveEvent(this.vente);
}
class VenteGetAllEvent extends VenteEvent {
  final int page;
  final int pageSize;
  VenteGetAllEvent(this.page,this.pageSize);
}

class GetVentesByTitle extends VenteEvent {
  final int page;
  final int pageSize;
  final String title ;
  GetVentesByTitle(this.page,this.pageSize,this.title);
}

class VenteErrorEvent extends VenteEvent {
  final String errorMessage;
  VenteErrorEvent(this.errorMessage) ;
}

