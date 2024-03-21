import 'package:get_it/get_it.dart';
import '../features/authentication/data/implementation/user_repository_impl.dart';
import '../features/authentication/domain/usecases/create_user_usecase.dart';
import '../features/authentication/domain/usecases/login_user_usecase.dart';
import '../features/authentication/presentation/widgets/login/bloc/login_bloc.dart';
import '../features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';

final getIt = GetIt.instance;

void initDependencies() {
  if (!GetIt.I.isRegistered<SignupBloc>()) {
    getIt.registerLazySingleton <SignupBloc>(()=>SignupBloc( CreateUseCase(userRepository: UserRepositoryImpl()) ));
  }

  if (!GetIt.I.isRegistered<LoginBloc>()) {
    getIt.registerLazySingleton <LoginBloc>(()=>LoginBloc( LoginUserUseCase(userRepository: UserRepositoryImpl()) ));
  }

}