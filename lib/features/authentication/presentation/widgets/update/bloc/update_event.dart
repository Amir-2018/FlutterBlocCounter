
import 'package:flutter/cupertino.dart';

import '../../../../domain/model/user.dart';


@immutable
abstract class UpdateEvent {}

class LoadUpdateUserEvent extends UpdateEvent {}

class UpdateUserEvent extends UpdateEvent {
  final String username;
  final User user;
  UpdateUserEvent(this.username,this.user);
}
