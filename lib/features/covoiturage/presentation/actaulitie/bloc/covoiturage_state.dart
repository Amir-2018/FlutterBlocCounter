part of 'covoiturage_bloc.dart';

@immutable
abstract class CovoiturageState {}

class CovoiturageInitial extends CovoiturageState {}

class CovoiturageSuccessState extends CovoiturageState {
  final CovoiturageModel covoiturageModel;
  CovoiturageSuccessState(this.covoiturageModel);
}

class CovoiturageSuccessMessageState extends CovoiturageState {
  final String messageSuccessInsert;
  CovoiturageSuccessMessageState(this.messageSuccessInsert);
}

class ListCovoituragesSuccessMessageState extends CovoiturageState {
  final List<CovoiturageModel> listCovoiturages;
  ListCovoituragesSuccessMessageState(this.listCovoiturages);
}
class FilterListCovoituragesSuccessMessageState extends CovoiturageState {
  final List<CovoiturageModel> listacovoiturages;
  FilterListCovoituragesSuccessMessageState(this.listacovoiturages);
}

class CovoiturageErrorState extends CovoiturageState {
  final String errorMessage;
  CovoiturageErrorState(this.errorMessage) ;
}

class CovoiturageEmptyState extends CovoiturageState {
  final String message;
  CovoiturageEmptyState(this.message) ;
}

class CovoiturageLoadingState  extends CovoiturageState{

}

