part of 'vente_bloc.dart';

@immutable
abstract class VenteState {}

class VenteInitial extends VenteState {}

class VenteSuccessState extends VenteState {
  final Vente vente;
  VenteSuccessState(this.vente);
}

class VenteSuccessMessageState extends VenteState {
  final String messageSuccessInsert;
  VenteSuccessMessageState(this.messageSuccessInsert);
}

class ListVenteSuccessMessageState extends VenteState {
  final List<Vente> ventes;
  ListVenteSuccessMessageState(this.ventes);
}
class FilterListVenteSuccessMessageState extends VenteState {
  final List<Vente> ventes;
  FilterListVenteSuccessMessageState(this.ventes);
}

class FilterListVenteSuccessMessageVentesouAchatState extends VenteState {
  final List<Vente> ventes;
  FilterListVenteSuccessMessageVentesouAchatState(this.ventes);
}

class VenteErrorState extends VenteState {
  final String errorMessage;
  VenteErrorState(this.errorMessage) ;
}

class VenteLoadingState  extends VenteState{

}

class VenteEmptyState extends VenteState {
  final String message;
  VenteEmptyState(this.message) ;
}

