part of 'actualite_bloc.dart';

@immutable
abstract class ActualiteEvent {}

@immutable
abstract class UserEvent {}

class ActualiteEventInitial extends ActualiteEvent {}

class ActualiteSaveEvent extends ActualiteEvent {
  final Actualite actualite;
  ActualiteSaveEvent(this.actualite);
}
class ActualiteGetAllEvent extends ActualiteEvent {
  final int page;
  final int pageSize;
  ActualiteGetAllEvent(this.page,this.pageSize);
}

class GetActualitiesByTitle extends ActualiteEvent {
  final int page;
  final int pageSize;
  final String title ;
  GetActualitiesByTitle(this.page,this.pageSize,this.title);
}

class ActualiteErrorEvent extends ActualiteEvent {
  final String errorMessage;
  ActualiteErrorEvent(this.errorMessage) ;
}

class MakeTexFieldEmptyEvent extends ActualiteEvent {}

class GetActualitesOfTodays extends ActualiteEvent {}

class GetActualitiesByTitleForservicesPageEvent extends ActualiteEvent {
  final int page;
  final int pageSize;
  final String title ;
  GetActualitiesByTitleForservicesPageEvent(this.page,this.pageSize,this.title);
}