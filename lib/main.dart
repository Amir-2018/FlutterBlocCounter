import 'package:bloc_app/features/authentication/presentation/widgets/get_user_bloc.dart';
import 'package:flutter/material.dart';
import 'features/authentication/presentation/widgets/changepassword.dart';
import 'features/authentication/presentation/widgets/login.dart';
import 'features/authentication/presentation/widgets/signup/signup.dart';
import 'features/authentication/presentation/widgets/verifyCode.dart';
import 'features/authentication/presentation/widgets/verifyEmail.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Chotrana smart village',
      debugShowCheckedModeBanner: false,
      // Define routes
      initialRoute: '/login',
      routes: {
        '/signup': (context) => SignupWidget(),
        /*'/verifyEmail': (context) => const VerifyEmail(),
        '/changePassword': (context) => const ChangePasswordWidget(),
        '/verifyCode': (context) => const VerifyCode(),*/
        '/login': (context) => Login(),
        /* '/user': (context) => GetUserBloc(),*/
      },
    ),
  );
}
