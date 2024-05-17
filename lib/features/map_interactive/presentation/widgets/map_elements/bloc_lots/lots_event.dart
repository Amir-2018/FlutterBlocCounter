part of 'lots_bloc.dart';

@immutable
abstract class LotsEvent {}
class GetLotEvent extends LotsEvent {}

class SendLotsEvent extends LotsEvent {
  final List<Lot> lots;
  SendLotsEvent({required this.lots});
}
