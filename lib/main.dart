import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pfechotranasmartvillage/features/authentication/bloc/user_bloc.dart';
import 'core/dependencies_injection.dart';
import 'features/authentication/presentation/widgets/backgroundScreen.dart';
import 'features/authentication/presentation/widgets/change_password/change_password.dart';
import 'features/authentication/presentation/widgets/home/get_started.dart';
import 'features/authentication/presentation/widgets/home/mode.dart';
import 'features/authentication/presentation/widgets/home/services.dart';
import 'features/authentication/presentation/widgets/login/login.dart';
import 'features/authentication/presentation/widgets/profile_info.dart';
import 'features/authentication/presentation/widgets/signup/signup.dart';
import 'features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'features/authentication/presentation/widgets/update/update_profile.dart';
import 'features/authentication/presentation/widgets/verify_email/verify_email.dart';
import 'features/map_interactive/bloc/zone_bloc.dart';
import 'features/map_interactive/bloc/zone_event.dart';
import 'features/map_interactive/presentation/widgets/map.dart';
import 'features/map_interactive/presentation/widgets/map_elements/map_home_page.dart';

//https://github.com/matiasdev30/flutter_map_draw_route/tree/main/flutter_map_draw_route

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => getIt<UserBloc>(),
        ),

        BlocProvider<ZoneBloc>(
          create: (context) => getIt<ZoneBloc>()..add((GetZoneEvent())),
        ),
        // Add more BlocProviders if needed
      ],
      child: FutureBuilder<String>(
        future: storage.read(key: 'access_token').then((value) => value ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint(snapshot.toString());
            String initialRoute = (snapshot.hasData && snapshot.data != '') ? '/get_started' : '/get_started';

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
                '/services': (context) => Services(),
                '/mode': (context) => Mode(),
                '/profileInfo': (context) => const ProfileInfo(),
                '/simpleBottomNavigation': (context) => const ButtonNavigationBar(),
                // '/get_started': (context) => GetStartedApp(),
                '/map': (context) => OpenStreetMapSearchAndPick(onPicked: (PickedData pickedData) {}),
                '/get_started': (context) => BackgroundScreen(),


              },
            );
          } else {
            return const CircularProgressIndicator(); // Show a loading indicator while checking for the token
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
