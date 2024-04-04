import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import '../../../../domain/model/auth_user.dart';
import '../../../../domain/usecases/login_user_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUserUseCase loginUserUseCase;

  LoginBloc(this.loginUserUseCase) : super(LoginInitial()) {
    on<SubmitUserEvent>((event, emit) async {
      try {
        debugPrint('Login Executed');
        final user = await loginUserUseCase.call(event.authUser);
        debugPrint('User Submitted is $user');
        if (user) {
          // Save the username in the secure storage
          final storage = new FlutterSecureStorage();
          await storage.write(key: "username", value: event.authUser.username);

          emit(LoginSuccessState("Login with success"));
        } else {
          emit(LoginErrorState("Failed to login"));
        }
      } catch (e) {
        debugPrint('Exception: $e');
        emit(LoginErrorState("An error occurred: $e"));
      }
    });
  }
}
