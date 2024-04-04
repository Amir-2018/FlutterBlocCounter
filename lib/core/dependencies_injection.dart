import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:pfechotranasmartvillage/features/authentication/domain/usecases/update_user_usecase.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/data/implementation/map_repository_impl.dart';
import '../features/authentication/bloc/user_bloc.dart';
import '../features/authentication/data/datasources/local/database_helper.dart';
import '../features/authentication/data/implementation/user_repository_impl.dart';
import '../features/authentication/domain/usecases/create_user_usecase.dart';
import '../features/authentication/domain/usecases/get_user_info_usecase.dart';
import '../features/authentication/domain/usecases/login_user_usecase.dart';
import '../features/authentication/presentation/widgets/login/bloc/login_bloc.dart';
import '../features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';
import '../features/authentication/presentation/widgets/update/bloc/update_bloc.dart';
import '../features/map_interactive/bloc/zone_bloc.dart';
import '../features/map_interactive/domain/usecases/get_list_zone_usecase.dart';

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
        UserBloc(GestUserInfoUseCase(userRepository: UserRepositoryImpl(),),LogOutUseCase(userRepository: UserRepositoryImpl())));
  }

  if (!GetIt.I.isRegistered<DatabaseHelper>()) {
    getIt.registerLazySingleton<DatabaseHelper>(() =>
        DatabaseHelper());
  }

  if (!GetIt.I.isRegistered<UpdateBloc>()) {
    getIt.registerLazySingleton<UpdateBloc>(()=>
        UpdateBloc(UpdateUseCase(userRepository: UserRepositoryImpl())));
  }

  if (!GetIt.I.isRegistered<FlutterSecureStorage>()) {
    getIt.registerLazySingleton<FlutterSecureStorage>(() =>  FlutterSecureStorage());
  }

  if (!GetIt.I.isRegistered<MapRepositoryImpl>()) {
    getIt.registerLazySingleton<MapRepositoryImpl>(() =>MapRepositoryImpl());
  }

  if (!getIt.isRegistered<ZoneBloc>()) {
    getIt.registerLazySingleton<ZoneBloc>(
          () => ZoneBloc(GetZoneBounderiesUseCase(mapRepository: MapRepositoryImpl())),
    );
  }

}


