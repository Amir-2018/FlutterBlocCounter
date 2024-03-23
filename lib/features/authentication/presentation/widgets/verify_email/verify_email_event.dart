part of 'verify_email_bloc.dart';

@immutable
abstract class VerifyEmailEvent {}
 class VerifyEmailSendEvent extends VerifyEmailEvent{
  final String message ;
  VerifyEmailSendEvent(this.message);
}

