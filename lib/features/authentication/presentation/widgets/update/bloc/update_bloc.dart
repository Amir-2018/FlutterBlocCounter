import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/domain/usecases/update_user_usecase.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/update/bloc/update_event.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/update/bloc/update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateUserState> {
  final UpdateUseCase updateUseCase;
  UpdateBloc(
      this.updateUseCase,
      ) : super(UpdateInitialState()) {
    on<UpdateUserEvent>((event, emit) async {
      try {
        debugPrint('Update Executed');
        debugPrint(event.username);
        final user = await updateUseCase.call(event.username,event.user);
        debugPrint('User is ${user.toString()}');
        emit(UpdateSuccessState("User created with success"));
      } catch (e) {
        debugPrint('Erro with signup $e');
        emit(UpdateErrorState("User does not created with success"));
      }
    });
  }
}