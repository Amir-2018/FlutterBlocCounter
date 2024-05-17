part of 'etablissement_bloc.dart';

@immutable
abstract class EtablissementState {}

class EtablissementInitialState extends EtablissementState {}

class EtablissementSuccessState extends EtablissementState {
  final List<Establishment> etablissements;
  EtablissementSuccessState(this.etablissements);
}
class EtablissementSuccessLocalState extends EtablissementState {
  final List<Establishment> etablissements;
  EtablissementSuccessLocalState(this.etablissements);
}


class PositionErrorState extends EtablissementState {
  final String errorEstablishment;
  PositionErrorState(this.errorEstablishment);
}


class PositionNomEtablisseentState extends EtablissementState {
  final String nomEstablishment;
  PositionNomEtablisseentState(this.nomEstablishment);
}



