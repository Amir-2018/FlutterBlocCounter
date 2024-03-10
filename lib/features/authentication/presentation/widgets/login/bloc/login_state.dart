import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class SignupUserState {}

class SignupInitialState extends SignupUserState {}

class SignupSuccessState extends SignupUserState {
  final String successMessage;
  SignupSuccessState(this.successMessage);
}

class SignupErrorState extends SignupUserState {
  final String errormessage;
  SignupErrorState(this.errormessage);
}

class SignupNullState extends SignupUserState {
  final String nullmessage;
  SignupNullState(this.nullmessage);
}
