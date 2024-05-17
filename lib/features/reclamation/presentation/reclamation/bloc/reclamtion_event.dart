part of 'reclamation_bloc.dart';

@immutable
abstract class ReclamationEvent {}



class ReclamationEventInitial extends ReclamationEvent {}

class ReclamationSendEvent extends ReclamationEvent {
  final Reclamation reclamation;
  ReclamationSendEvent(this.reclamation);
}



