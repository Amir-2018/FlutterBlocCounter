import 'package:bloc_app/features/authentication/domain/repository/user_repository.dart';
import 'package:bloc_app/features/authentication/presentation/bloc/bloc_api/auth_event.dart';
import 'package:bloc_app/features/authentication/presentation/bloc/bloc_api/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(InitialUserLoadedState()) {
    on<LoadUserEvent>((event, emit) async {
      try {
        final user = await _userRepository.getUser();
        debugPrint('I bring you the user');
        emit(UserLoadedState(user));
      } catch (e) {
        debugPrint('There is error my friend');
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
