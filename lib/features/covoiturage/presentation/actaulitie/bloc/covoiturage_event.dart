part of 'covoiturage_bloc.dart';

@immutable
abstract class CovoiturageEvent {}



class CovoiturageEventInitial extends CovoiturageEvent {}

class CovoiturageSaveEvent extends CovoiturageEvent {
  final CovoiturageModel covoiturageModel;
  CovoiturageSaveEvent(this.covoiturageModel);
}
class CovoiturageGetAllEvent extends CovoiturageEvent {
  final int page;
  final int pageSize;
  CovoiturageGetAllEvent(this.page,this.pageSize);
}

class GetCovoituragesByTitleEvent extends CovoiturageEvent {
  final int page;
  final int pageSize;
  final String title ;
  GetCovoituragesByTitleEvent(this.page,this.pageSize,this.title);
}

class CovoiturageErrorEvent extends CovoiturageEvent {
  final String errorMessage;
  CovoiturageErrorEvent(this.errorMessage) ;
}

