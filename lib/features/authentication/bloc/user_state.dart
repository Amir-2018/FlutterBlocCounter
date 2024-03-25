import 'package:flutter/cupertino.dart';

import '../domain/model/user.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

// if user is loaded with success

class UserSuccessState extends UserState {
  final User userObject;
  UserSuccessState(this.userObject);
}

// if user is failed
class UserFailedState extends UserState {
  final User userObject;
  UserFailedState(this.userObject);
}
