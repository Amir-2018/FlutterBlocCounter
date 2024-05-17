part of 'lots_bloc.dart';

@immutable
abstract class LotsState {}

class LotInitialState extends LotsState {}

class LotlistSuccessState extends LotsState {
  final List<Lot> lots;
  LotlistSuccessState(this.lots);
}

class LotErrorState extends LotsState {
  final String errorLot;
  LotErrorState(this.errorLot);
}