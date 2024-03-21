
import 'package:flutter/cupertino.dart';

import '../../../../domain/model/user.dart';


@immutable
abstract class SignupEvent {}

class LoadUserEvent extends SignupEvent {}

class CreateUserEvent extends SignupEvent {
  final User user;
  CreateUserEvent(this.user);
}
