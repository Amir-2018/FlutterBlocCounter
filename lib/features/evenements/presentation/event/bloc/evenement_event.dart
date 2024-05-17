part of 'evenement_bloc.dart';

@immutable
abstract class EvenementEvent {}


class EvenementEventInitial extends EvenementEvent {}

class EvenementSaveEvent extends EvenementEvent {
  final Evenement evenement;
  EvenementSaveEvent(this.evenement);
}
class EvenementGetAllEvent extends EvenementEvent {
  final int page;
  final int pageSize;
  EvenementGetAllEvent(this.page,this.pageSize);
}

class GetEvenementGetAllEventsByTitle extends EvenementEvent {
  final int page;
  final int pageSize;
  final String title ;
  GetEvenementGetAllEventsByTitle(this.page,this.pageSize,this.title);
}

class EvenementErrorEvent extends EvenementEvent {
  final String errorMessage;
  EvenementErrorEvent(this.errorMessage) ;
}

class SendPositionEvent extends EvenementEvent {}


class EvenementCrudGetAllEvent extends EvenementEvent {
    final String username ;
    EvenementCrudGetAllEvent(this.username) ;

}

class EvenementCrudDeleteEvent extends EvenementEvent {
  final int id ;
  EvenementCrudDeleteEvent(this.id) ;

}


class EvenementUpdateEvent extends EvenementEvent {
  final Evenement evenement;
  EvenementUpdateEvent(this.evenement);
}



