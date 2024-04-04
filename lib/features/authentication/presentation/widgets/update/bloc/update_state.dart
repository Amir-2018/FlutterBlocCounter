
import 'package:flutter/cupertino.dart';

@immutable
abstract class UpdateUserState {}

class UpdateInitialState extends UpdateUserState {}

class UpdateSuccessState extends UpdateUserState {
  final String successMessage;
  UpdateSuccessState(this.successMessage);
}

class UpdateErrorState extends UpdateUserState {
  final String errormessage;
  UpdateErrorState(this.errormessage);
}

class UpdateNullState extends UpdateUserState {
  final String nullmessage;
  UpdateNullState(this.nullmessage);
}
