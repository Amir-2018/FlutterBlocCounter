import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfechotranasmartvillage/features/authentication/bloc/user_event.dart';
import 'package:pfechotranasmartvillage/features/authentication/bloc/user_state.dart';
import '../../../core/constantes.dart';
import '../domain/usecases/get_user_info_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
class UserBloc extends Bloc<UserEvent, UserState> {

  GestUserInfoUseCase getUserUserUseCase;
  LogOutUseCase logOutUseCase ;

  UserBloc(this.getUserUserUseCase,this.logOutUseCase) : super(UserInitial()) {

    on<UserInfoEventInitial>((event, emit) async {
      try {
        debugPrint('Im gonna bring the user');

        final storage = new FlutterSecureStorage();
        final String? username = await storage.read(key: 'username') ;
        final user = await getUserUserUseCase.call('$username');

        if (user.id != null) {

          emit(UserSuccessState(user));
        } else {
          debugPrint('User ');

          emit(UserFailedState(EMPTY_USER));
        }
      } catch (e) {
        debugPrint('Exception : $e');
      }

    });

    on<LogOutEvent>((event, emit) async {
      try {

        final user = await logOutUseCase.call();
        if (user) {

          emit(LogOutSucessState(true));
        } else {
          debugPrint('User ');

          emit(LogOutErrorState(false));
        }
      } catch (e) {
        debugPrint('Exception with logout  : $e');
      }

    });

  }
}
