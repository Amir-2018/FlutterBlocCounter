import 'dart:developer';

import 'package:flutter/material.dart';
import 'features/authentication/presentation/widgets/login.dart';
import 'features/authentication/presentation/widgets/profile_info.dart';
import 'features/authentication/presentation/widgets/signup/signup.dart';
import 'features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'features/authentication/presentation/widgets/update_profile.dart';
import 'features/authentication/presentation/widgets/verifyEmail.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Chotrana smart village',
      debugShowCheckedModeBanner: false,
      // Define routes
      initialRoute: '/login',
      routes: {
        '/update_profile': (context) => UpdteProfile(),
        '/signup': (context) => SignupWidget(),
        '/verifyEmail': (context) =>  VerifyEmail(),
        /*'/changePassword': (context) => const ChangePasswordWidget(),
        '/verifyCode': (context) => const VerifyCode(),*/
        '/login': (context) => Login(),
        '/profileinfo': (context) => ProfileInfo(),
        '/simpleBottomNavigation': (context) => ButtonNavigationBar(),


      },
    ),
  );
}
