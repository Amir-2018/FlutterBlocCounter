part of 'etablissement_bloc.dart';

@immutable
abstract class EtablissementEvent {}

class GetEtablissementEvent extends EtablissementEvent {}

class SendEtablissementEvent extends EtablissementEvent {
  final Establishment etablissement;
  SendEtablissementEvent({required this.etablissement});
}

class SendEtablissemenEmptytEvent extends EtablissementEvent {
  final List<Establishment> etablissement;
  SendEtablissemenEmptytEvent({this.etablissement = const []});
}


class SendEtablissementLocalEvent extends EtablissementEvent {}

class SendEtablissementPoslEvent extends EtablissementEvent {
  final String etablissementPos;
  SendEtablissementPoslEvent({required this.etablissementPos});
}
