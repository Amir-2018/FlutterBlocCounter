import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent {}

class UserInfoEventInitial extends UserEvent {}

class UserInfoEvent extends UserEvent {
  final User userInfo;
  UserInfoEvent(this.userInfo);
}
