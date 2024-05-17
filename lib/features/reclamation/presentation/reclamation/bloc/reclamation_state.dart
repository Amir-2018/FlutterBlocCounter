part of 'reclamation_bloc.dart';

@immutable
abstract class ReclamationState {}

class ReclamationInitial extends ReclamationState {}

class ReclamationSuccessState extends ReclamationState {}

class ReclamationErrorState extends ReclamationState {}




