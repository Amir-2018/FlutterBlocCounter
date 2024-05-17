part of 'actualite_bloc.dart';

@immutable
abstract class ActualiteState {}

class ActualiteInitial extends ActualiteState {}

class ActualiteSuccessState extends ActualiteState {
  final Actualite actualite;
  ActualiteSuccessState(this.actualite);
}

class ActualiteSuccessMessageState extends ActualiteState {
  final String messageSuccessInsert;
  ActualiteSuccessMessageState(this.messageSuccessInsert);
}

class ListActualiteSuccessMessageState extends ActualiteState {
  final List<Actualite> listactualities;
  ListActualiteSuccessMessageState(this.listactualities);
}

class FilterListActualiteSuccessMessageState extends ActualiteState {
  final List<Actualite> listactualities;
  FilterListActualiteSuccessMessageState(this.listactualities);
}

class FilterListActualiteSuccessMessageForServicesState extends ActualiteState {
  final List<Actualite> listactualities;
  FilterListActualiteSuccessMessageForServicesState(this.listactualities);
}


class ActualiteErrorState extends ActualiteState {
  final String errorMessage;
  ActualiteErrorState(this.errorMessage) ;
}

class ActualiteEmptyState extends ActualiteState {
  final String message;
  ActualiteEmptyState(this.message) ;
}

class ActualiteLoadingState  extends ActualiteState{

}

class ActualiteMakeTexFieldEmptyState extends ActualiteState {

}

class ListActualiteSuccessOfTodaye extends ActualiteState {
  final List<Actualite> listactualities;
  ListActualiteSuccessOfTodaye(this.listactualities);
}

class ActualiteLoadingServicesState extends ActualiteState {}
