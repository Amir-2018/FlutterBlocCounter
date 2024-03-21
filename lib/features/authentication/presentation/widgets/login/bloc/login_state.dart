part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {
  final String successMessage;
  LoginSuccessState(this.successMessage);
}

class LoginErrorState extends LoginState {
  final String errormessage;
  LoginErrorState(this.errormessage);
}

class LoginNullState extends LoginState {
  final String nullmessage;
  LoginNullState(this.nullmessage);
}