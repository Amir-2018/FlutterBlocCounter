import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_event.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/create_user_usecase.dart';

class SignupBloc extends Bloc<SignupEvent, SignupUserState> {
  final CreateUseCase createUseCase;
  SignupBloc(
    this.createUseCase,
  ) : super(SignupInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      try {
        debugPrint('Signup Executed');
        final user = await createUseCase.call(event.user);
        debugPrint('User is $user');
        emit(SignupSuccessState("User created with success"));
      } catch (e) {
        debugPrint('Erro with signup $e');
        emit(SignupErrorState("User does not created with success"));
      }
    });
  }
}
