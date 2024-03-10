import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class SignupEvent {}

class LoadUserEvent extends SignupEvent {}

class CreateUserEvent extends SignupEvent {
  final User user;
  CreateUserEvent(this.user);
}
