import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/annonces/presentation/list_annonce/list_annonce.dart';
import 'package:pfechotranasmartvillage/features/authentication/bloc/user_bloc.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/presentation/actaulitie/bloc/covoiturage_bloc.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/event/event_widget.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_etablissement/etablissement_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_lots/lots_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_bloc.dart';
import 'package:pfechotranasmartvillage/features/reclamation/presentation/reclamation/bloc/reclamation_bloc.dart';
import 'package:pfechotranasmartvillage/features/reclamation/presentation/reclamation/reclamation.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/bloc/vente_bloc.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/vente_widget.dart';
import 'core/dependencies_injection.dart';
import 'core/widgets/post_widget.dart';
import 'features/Settings.dart';
import 'features/annonces/presentation/actaulitie/actualitie_widget.dart';
import 'features/annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import 'features/authentication/presentation/widgets/backgroundScreen.dart';
import 'features/authentication/presentation/widgets/change_password/change_password.dart';
import 'features/authentication/presentation/widgets/home/mode.dart';
import 'features/authentication/presentation/widgets/home/services.dart';
import 'features/authentication/presentation/widgets/login/login.dart';
import 'features/authentication/presentation/widgets/profile_info.dart';
import 'features/authentication/presentation/widgets/signup/signup.dart';
import 'features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'features/authentication/presentation/widgets/update/update_profile.dart';
import 'features/authentication/presentation/widgets/verify_email/verify_email.dart';
import 'features/carouselSlides.dart';
import 'features/covoiturage/presentation/covoiturage/complete_covoiturage.dart';
import 'features/covoiturage/presentation/covoiturage/covoiturage.dart';
import 'features/covoiturage/presentation/covoiturage/covoiturage_widget_details.dart';
import 'features/covoiturage/presentation/list_covoiturages/list_covoiturage.dart';
import 'features/evenements/presentation/crud/evenement_crud.dart';
import 'features/evenements/presentation/event/bloc/evenement_bloc.dart';
import 'features/evenements/presentation/event/complete_event_widget.dart';
import 'features/evenements/presentation/list_events/list_evenements.dart';
import 'features/map_interactive/bloc/zone_bloc.dart';
import 'features/map_interactive/bloc/zone_event.dart';
import 'features/map_interactive/presentation/widgets/map_elements/bloc_position/map_home_page/map_home_page.dart';
import 'features/productpage.dart';
import 'features/venteAchat/presentation/vente/vente_widget_details.dart';
import 'homepage.dart';

//https://github.com/matiasdev30/flutter_map_draw_route/tree/main/flutter_map_draw_route

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {

    initDependencies() ;
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => getIt<UserBloc>(),
        ),

        BlocProvider<ZoneBloc>(
          create: (context) => getIt<ZoneBloc>()..add((GetZoneEvent())),
        ),

        BlocProvider<PositionBloc>(
          create: (context) => getIt<PositionBloc>()),

        BlocProvider<EstablishmentBloc>(
            create: (context) => getIt<EstablishmentBloc>()),

        BlocProvider<LotsBloc>(
            create: (context) => getIt<LotsBloc>()),

        BlocProvider<ActualiteBloc>(
            create: (context) => getIt<ActualiteBloc>()),

        BlocProvider<VenteBloc>(
            create: (context) => getIt<VenteBloc>()),
        BlocProvider<ReclamationBloc>(
            create: (context) => getIt<ReclamationBloc>()),

        BlocProvider<CovoiturageBloc>(
            create: (context) => getIt<CovoiturageBloc>()),

        BlocProvider<EvenementBloc>(
            create: (context) => getIt<EvenementBloc>()),

      ],
      child: FutureBuilder<String>(//
        future: storage.read(key: 'access_token').then((value) => value ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint(snapshot.toString());
            String initialRoute = (snapshot.hasData && snapshot.data != '') ? '/services' : '/services';

            return MaterialApp(
              title: 'Chotrana smart village',
              debugShowCheckedModeBanner: false,
              initialRoute: initialRoute,
              routes: {
                '/update_profile': (context) => const UpdteProfile(),
                '/signup': (context) => const SignupWidget(),
                '/verifyEmail': (context) => const VerifyEmail(),
                '/changePassword': (context) => const ChangePassword(),
                '/login': (context) => const LoginWidget(),
                '/services': (context) =>  Services(),
                '/mode': (context) => Mode(),
                '/profileInfo': (context) {
                  return FutureBuilder(
                    future: storage.read(key: 'access_token'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ProfileInfo();
                        } else {
                          return LoginWidget();
                        }
                      } else {
                        return CircularProgressIndicator(); // Or any other loading indicator
                      }
                    },
                  );
                },

                '/simpleBottomNavigation': (context) => const ButtonNavigationBar(),
                // '/get_started': (context) => GetStartedApp(),
                '/map': (context) => OpenStreetMapSearchAndPick(onPicked: (PickedData pickedData) {}),
                '/get_started': (context) => HabitApp(),
                '/actualite': (context) =>   ActualitieWidget(),
                '/addVente': (context) =>   VenteWidget(),
                '/covoiturage': (context) =>   Covoiturage(),
                '/completeCovoiturage': (context) =>   CompleteCovoiturage(),
                '/listAnnoces': (context) =>   ListAnnoces(),
                '/listCovoiturages': (context) =>   ListCovoiturages(),
                '/listVentes': (context) =>   ListVentes(),
                '/detaientes': (context) =>   ListVentes(),
                '/detailesCovoiturage': (context) => CovoituragesWidgetDetails.fromRoute(context),
                '/detailesVentes': (context) => VenteWidgetDetails.fromRoute(context),
                '/reclamation': (context) =>   ReclamationWidget(),
                '/productDetailsPage': (context) =>   ProductDetailsPage(imageUrl: 'https://th.bing.com/th/id/OIP.T7GEhmrNhSTo_465vl2bVwAAAA?rs=1&pid=ImgDetMain',),
                '/event': (context) =>   EventWidget(),
                '/completeEvent': (context) =>   CompleteEventWidget(),
                '/listEvenements': (context) =>   ListEvenements(),
                '/homepage': (context) =>   HabitApp(),
                '/postWidget': (context) => SecondFormCovoiturage.fromRoute(context),
                '/settingsWidget': (context) =>   SO(),
                '/dashEvents': (context) =>   UserManagementScreen(),








                //'/secondFormCovoiturage': (context) => SecondFormCovoiturage.fromRoute(context),



              },
            );
          } else {

            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
