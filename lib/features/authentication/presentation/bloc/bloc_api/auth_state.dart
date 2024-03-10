import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class UserState {}

/*class UserLoadingState extends UserState {
  @override
  Object get props => [];
}*/
class InitialUserLoadedState extends UserState {}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
}

// Bloc for signup

class SignupState extends UserState {
  final User user;
  SignupState(this.user);
}

class SignupStateError extends UserState {
  final String message;
  SignupStateError(this.message);
}
