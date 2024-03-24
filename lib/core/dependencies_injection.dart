import 'package:bloc_app/features/authentication/bloc/user_bloc.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:bloc_app/features/authentication/domain/usecases/get_user_info_usecase.dart';
import 'package:get_it/get_it.dart';
import '../features/authentication/data/implementation/user_repository_impl.dart';
import '../features/authentication/domain/usecases/create_user_usecase.dart';
import '../features/authentication/domain/usecases/login_user_usecase.dart';
import '../features/authentication/presentation/widgets/login/bloc/login_bloc.dart';
import '../features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';

final getIt = GetIt.instance;

void initDependencies() {
  if (!GetIt.I.isRegistered<SignupBloc>()) {
    getIt.registerLazySingleton<SignupBloc>(
        () => SignupBloc(CreateUseCase(userRepository: UserRepositoryImpl())));
  }

  if (!GetIt.I.isRegistered<LoginBloc>()) {
    getIt.registerLazySingleton<LoginBloc>(() =>
        LoginBloc(LoginUserUseCase(userRepository: UserRepositoryImpl())));
  }

  if (!GetIt.I.isRegistered<UserBloc>()) {
    getIt.registerLazySingleton<UserBloc>(() =>
        UserBloc(GestUserInfoUseCase(userRepository: UserRepositoryImpl())));
  }
}
