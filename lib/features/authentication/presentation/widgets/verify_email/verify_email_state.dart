part of 'verify_email_bloc.dart';

@immutable
abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class EmailSuccessState extends VerifyEmailState {
  final String successMessage  ;
  EmailSuccessState(this.successMessage) ;
}
class EmailErrorState extends VerifyEmailState {
  final String errorMessage  ;
  EmailErrorState(this.errorMessage) ;
}
