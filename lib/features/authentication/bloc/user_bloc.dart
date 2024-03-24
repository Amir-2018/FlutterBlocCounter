import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:bloc_app/core/constantes.dart';
import 'package:bloc_app/features/authentication/bloc/user_event.dart';
import 'package:bloc_app/features/authentication/bloc/user_state.dart';
import 'package:bloc_app/features/authentication/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final storage = new FlutterSecureStorage();

  GestUserInfoUseCase getUserUserUseCase;

  UserBloc(this.getUserUserUseCase) : super(UserInitial()) {
    on<UserInfoEventInitial>((event, emit) async {
      try {
        debugPrint('Im gonna bring the user');

        final user = await getUserUserUseCase.call('amir');

        if (user.id != null) {
          /* await storage.write(key: "user", value: user.toString());
          String? getUserInfo = await storage.read(key: "user");
          debugPrint('User type  is ${getUserInfo.runtimeType}');
          Map<String, dynamic> userInfoMap = {};
          if (getUserInfo != null) {
            userInfoMap = Map<String, dynamic>.from(json.decode(getUserInfo));
          }
          debugPrint('User type  is ${userInfoMap.runtimeType}');*/

          emit(UserSuccessState(user));
        } else {
          emit(UserFailedState(EMPTY_USER));
        }
      } catch (e) {
        debugPrint('Exception : $e');
      }
    });
  }
}
