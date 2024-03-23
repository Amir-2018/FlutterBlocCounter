import 'package:bloc/bloc.dart';
import 'package:bloc_app/core/constantes.dart';
import 'package:bloc_app/features/authentication/bloc/user_event.dart';
import 'package:bloc_app/features/authentication/bloc/user_state.dart';
import 'package:bloc_app/features/authentication/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter/cupertino.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  GestUserInfoUseCase getUserUserUseCase;

  UserBloc(this.getUserUserUseCase) : super(UserInitial()) {
    on<UserInfoEvent>((event, emit) async {
      try {
        debugPrint('Im gonna bring the user');

        final user = await getUserUserUseCase.call('amir');

        debugPrint('User to get info is $user');
        if (user.id != null) {
          emit(UserSuccessState(user));
        } else {
          emit(UserFailedState(EMTY_USER));
        }
      } catch (e) {
        debugPrint('Exception : $e');
      }
    });
  }
}
