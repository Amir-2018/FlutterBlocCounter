import 'package:bloc_app/features/authentication/domain/repository/user_repository.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_event.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupUserState> {
  final UserRepository _userRepository;

  SignupBloc(this._userRepository) : super(SignupInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      debugPrint('Event has been triggered with success');
      try {
        final user = await _userRepository.createUser(event.user);
        debugPrint('Signup Executed');
        emit(SignupSuccessState("User created with success"));
      } catch (e) {
        debugPrint('Erro with signup ');
        emit(SignupErrorState("User does not created with success"));
      }
    });
  }
}
