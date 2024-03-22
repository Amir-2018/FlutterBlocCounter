part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {}

class SubmitUserEvent extends LoginEvent {
  final AuthUser authUser;
  SubmitUserEvent(this.authUser);
}
