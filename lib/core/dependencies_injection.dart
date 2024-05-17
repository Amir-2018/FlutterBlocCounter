import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/annonces/data/implementation/actualite_repo_impl.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/repository/actualite_repository.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/usecases/insert_actualitie_usecase.dart';
import 'package:pfechotranasmartvillage/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:pfechotranasmartvillage/features/authentication/domain/usecases/update_user_usecase.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/usecases/delete_evenement_usecase.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/usecases/update_evenement_usecase.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/data/implementation/map_repository_impl.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/usecases/get_lots_usecase.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_lots/lots_bloc.dart';
import '../features/annonces/domain/usecases/get_actualities_of_today_usecase.dart';
import '../features/annonces/domain/usecases/get_list_actualities_by_title_usecase.dart';
import '../features/annonces/domain/usecases/get_list_actualities_usecase.dart';
import '../features/annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import '../features/authentication/bloc/user_bloc.dart';
import '../features/evenements/data/implementation/event_repository_impl.dart';
import '../features/evenements/domain/usecases/get_evenements_by_username_usecase.dart';
import '../features/evenements/domain/usecases/insert_evenement_usecase.dart';
import '../features/evenements/presentation/event/bloc/evenement_bloc.dart';
import 'database/database_helper.dart';
import '../features/authentication/data/implementation/user_repository_impl.dart';
import '../features/authentication/domain/usecases/create_user_usecase.dart';
import '../features/authentication/domain/usecases/get_user_info_usecase.dart';
import '../features/authentication/domain/usecases/login_user_usecase.dart';
import '../features/authentication/presentation/widgets/login/bloc/login_bloc.dart';
import '../features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';
import '../features/authentication/presentation/widgets/update/bloc/update_bloc.dart';
import '../features/covoiturage/data/implementation/covoiturage_repo_impl.dart';
import '../features/covoiturage/data/implementation/covoiturage_repo_impl_functions.dart';
import '../features/covoiturage/domain/usecases/get_list_covoiturages_by_title_usecase.dart';
import '../features/covoiturage/domain/usecases/get_list_covoiturages_usecase.dart';
import '../features/covoiturage/domain/usecases/insert_covoiturage_usecase.dart';
import '../features/covoiturage/presentation/actaulitie/bloc/covoiturage_bloc.dart';
import '../features/map_interactive/bloc/zone_bloc.dart';
import '../features/map_interactive/domain/usecases/get_establishments_usecase.dart';
import '../features/map_interactive/domain/usecases/get_list_zone_usecase.dart';
import '../features/map_interactive/presentation/widgets/map_elements/bloc_etablissement/etablissement_bloc.dart';
import '../features/map_interactive/presentation/widgets/map_elements/bloc_position/position_bloc.dart';
import '../features/reclamation/data/implementation/reclamation_repo_impl.dart';
import '../features/reclamation/domain/usecases/insert_actualitie_usecase.dart';
import '../features/reclamation/presentation/reclamation/bloc/reclamation_bloc.dart';
import '../features/venteAchat/data/implementation/vente_achat_repository_impl.dart';
import '../features/venteAchat/domain/usecases/get_list_ventes_by_title_usecase.dart';
import '../features/venteAchat/domain/usecases/get_list_ventes_usecase.dart';
import '../features/venteAchat/domain/usecases/insert_vente_usecase.dart';
import '../features/venteAchat/presentation/vente/bloc/vente_bloc.dart';
import 'functions/functions.dart';

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

  if (!GetIt.I.isRegistered<PositionBloc>()) {
    getIt.registerLazySingleton<PositionBloc>(() =>PositionBloc());
  }


  if (!getIt.isRegistered<EstablishmentBloc>()) {
    getIt.registerLazySingleton<EstablishmentBloc>(
          () => EstablishmentBloc(GetEstablishmentsUseCase(mapRepository: MapRepositoryImpl())),
    );
  }
  if (!getIt.isRegistered<LotsBloc>()) {
    getIt.registerLazySingleton<LotsBloc>(
          () => LotsBloc(GetLotssUseCase(mapRepository: MapRepositoryImpl())),
    );
  }
  if (!GetIt.I.isRegistered<UserRepositoryImpl>()) {
    getIt.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());
  }
  if (!getIt.isRegistered<ActualiteBloc>()) {
    getIt.registerLazySingleton<ActualiteBloc>(
          () => ActualiteBloc(InsertActualityUsecase(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecase(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecaseByTitle(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesOfTodayeUsecase(actualiteRepository: ActualiteRepositoryImpl())),
    );
  }
  if (!getIt.isRegistered<VenteBloc>()) {
    getIt.registerLazySingleton<VenteBloc>(
          () => VenteBloc(InsertVenteUsecase(
              venteRepository: VenteAchatRepositoryImpl()),GetListVentesUsecase(venteRepository: VenteAchatRepositoryImpl()),GetListVentesByTitleUsecase(venteRepository: VenteAchatRepositoryImpl())),
    );
  }

  if (!getIt.isRegistered<CovoiturageBloc>()) {
    getIt.registerLazySingleton<CovoiturageBloc>(
          () =>
          CovoiturageBloc(InsertCovoiturageUsecase(
              covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecase(covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecaseByTitle(covoiturageRepository: CovoiturageRepositoryImpl())),
    );
  }
  if (!GetIt.I.isRegistered<Functions>()) {
    getIt.registerLazySingleton<Functions>(() =>Functions());
  }

  if (!GetIt.I.isRegistered<CovoiturageRepositoryImplFunctions>()) {
    getIt.registerLazySingleton<CovoiturageRepositoryImplFunctions>(() =>CovoiturageRepositoryImplFunctions());
  }

  if (!getIt.isRegistered<ReclamationBloc>()) {
    getIt.registerLazySingleton<ReclamationBloc>(
            () =>
            ReclamationBloc(InsertReclamationUsecase(
                reclamationRepository: ReclamtionRepositoryImpl()))
    );
  }

  if (!getIt.isRegistered<EvenementBloc>()) {
    getIt.registerLazySingleton<EvenementBloc>(
          () =>
          EvenementBloc( InsertEvenementUsecase(evenementRepository: EventRepositoryImpl()),GestEvenementsByUsernameUsecase(evenementRepository: EventRepositoryImpl()),DeleteEvenementUsecase(evenementRepository: EventRepositoryImpl()),UpdateEvenementUsecase(evenementRepository: EventRepositoryImpl())),
    );
  }

}


