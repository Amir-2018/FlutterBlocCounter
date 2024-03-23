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
      initialRoute: '/get_started',
      routes: {
        '/update_profile': (context) => UpdteProfile(),
        '/signup': (context) => SignupWidget(),
        '/verifyEmail': (context) => VerifyEmail(),
        '/changePassword': (context) => const ChangePassword(),
        /*'/verifyCode': (context) => const VerifyCode(),*/
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
