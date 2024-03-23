import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailEvent>((event, emit) {
      try {
        bool emailSent = false ;
        // Call the method implementation of verify email
        if (emailSent) {
          emit(EmailSuccessState("Le nouveau mot de passe a été envoyé à votre email"));
        } else {
          emit(EmailErrorState("Email n'existe pas"));
        }
      } catch (e) {
        debugPrint('Exception : $e');
      }
    });
  }
}
