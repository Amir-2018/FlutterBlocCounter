import 'package:bloc_app/features/authentication/presentation/bloc/signup_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/authentication/data/implementation/user_repository_implementation.dart';
import '../features/authentication/domain/usecases/create_user_usecase.dart';

final getIt = GetIt.instance;

void initDependencies() {
  if (!GetIt.I.isRegistered<SignupBloc>()) {
    getIt.registerLazySingleton<SignupBloc>(
        () => SignupBloc(CreateUseCase(userRepository: UserImplementation())));
  }
}
