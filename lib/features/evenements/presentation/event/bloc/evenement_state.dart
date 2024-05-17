part of 'evenement_bloc.dart';

@immutable
abstract class EvenementState {}

class EvenementInitial extends EvenementState {}

class ActualiteSuccessState extends EvenementState {
  final Evenement evenement;
  ActualiteSuccessState(this.evenement);
}

class EnevtSuccessState extends EvenementState {
  final String  messageSuccess;
  EnevtSuccessState(this.messageSuccess);
}


class EnevtErrorState extends EvenementState {
  final String  messageError;
  EnevtErrorState(this.messageError);
}


class EvenementSuccessMesgsaeState extends EvenementState {
  final String messageSuccessInsert;
  EvenementSuccessMesgsaeState(this.messageSuccessInsert);
}

class ListEvenementsSuccessMessageState extends EvenementState {
  final List<Evenement> evenementList;
  ListEvenementsSuccessMessageState(this.evenementList);
}
class FilterListEvenementSuccessMessageState extends EvenementState {
  final List<Evenement> listEvenements;
  FilterListEvenementSuccessMessageState(this.listEvenements);
}

class EvenementErrorState extends EvenementState {
  final String errorMessage;
  EvenementErrorState(this.errorMessage) ;
}

class EvenementErrorCrudState extends EvenementState {
  final String errorMessage;
  EvenementErrorCrudState(this.errorMessage) ;
}

class EvenementsEmptyState extends EvenementState {
  final String message;
  EvenementsEmptyState(this.message) ;
}

class SendPositionState extends EvenementState {
}

class EvenementsLoadingState  extends EvenementState{

}

class EvenementCrudSuccessMesgsaeState extends EvenementState {
  final List<Evenement> liestEveneets;
  EvenementCrudSuccessMesgsaeState(this.liestEveneets);
}


class EvenementSuccessDeleteState extends EvenementState {
  final String message;
  EvenementSuccessDeleteState(this.message) ;
}

class EvenementErrorDeleteState extends EvenementState {
  final String message;
  EvenementErrorDeleteState(this.message) ;
}


class EvenementSuccessUpdateState extends EvenementState {
  final String message;
  EvenementSuccessUpdateState(this.message) ;
}

class EvenementErrorUpdateState extends EvenementState {
  final String message;
  EvenementErrorUpdateState(this.message) ;
}

