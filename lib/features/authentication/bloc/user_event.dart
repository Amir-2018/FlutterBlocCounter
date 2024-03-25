import 'package:flutter/cupertino.dart';

import '../domain/model/user.dart';

@immutable
abstract class UserEvent {}

class UserInfoEventInitial extends UserEvent {}

class UserInfoEvent extends UserEvent {
  final User userInfo;
  UserInfoEvent(this.userInfo);
}
