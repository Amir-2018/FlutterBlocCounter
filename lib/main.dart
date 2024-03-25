import 'package:flutter/material.dart';
import 'features/authentication/presentation/widgets/change_password/change_password.dart';
import 'features/authentication/presentation/widgets/home/get_started.dart';
import 'features/authentication/presentation/widgets/home/mode.dart';
import 'features/authentication/presentation/widgets/home/services.dart';
import 'features/authentication/presentation/widgets/login/login.dart';
import 'features/authentication/presentation/widgets/profile_info.dart';
import 'features/authentication/presentation/widgets/signup/signup.dart';
import 'features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'features/authentication/presentation/widgets/update_profile.dart';
import 'features/authentication/presentation/widgets/verify_email/verify_email.dart';

//https://github.com/matiasdev30/flutter_map_draw_route/tree/main/flutter_map_draw_route
void main() {
  runApp(
    MaterialApp(
      title: 'Chotrana smart village',
      debugShowCheckedModeBanner: false,
      // Define routes
      initialRoute: '/profileinfo',
      routes: {
        '/update_profile': (context) => UpdteProfile(),
        '/signup': (context) => SignupWidget(),
        '/verifyEmail': (context) => VerifyEmail(),
        '/changePassword': (context) => const ChangePassword(),
        //'/verifyCode': (context) => const VerifyCode(),
        '/login': (context) => const LoginWidget(),
        '/services': (context) => Services(),
        '/mode': (context) => Mode(),
        '/profileinfo': (context) => ProfileInfo(),
        '/simpleBottomNavigation': (context) => ButtonNavigationBar(),
        '/get_started': (context) => GetStartedApp(),
      },
    ),
  );
}

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: storage.read(key: 'access_token').then((value) => value ?? ''), // Convert Future<String?> to Future<String>
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String initialRoute = snapshot.hasData ? '/profileinfo' : '/get_started';

          return MaterialApp(
            title: 'Chotrana smart village',
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            routes: {
              '/update_profile': (context) => UpdteProfile(),
              '/signup': (context) => SignupWidget(),
              '/verifyEmail': (context) => VerifyEmail(),
              '/changePassword': (context) => const ChangePassword(),
              '/login': (context) => const LoginWidget(),
              '/services': (context) => Services(),
              '/mode': (context) => Mode(),
              '/profileinfo': (context) => ProfileInfo(),
              '/simpleBottomNavigation': (context) => ButtonNavigationBar(),
              '/get_started': (context) => GetStartedApp(),
            },
          );
        } else {
          return CircularProgressIndicator(); // Show a loading indicator while checking for the token
        }
      },
    );
  }
}
*/