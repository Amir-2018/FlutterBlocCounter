import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}
