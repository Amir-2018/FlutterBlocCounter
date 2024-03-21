import 'dart:convert';

import '../model/auth_user.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import 'package:http/http.dart' as http;

class CreateUseCase {

  final UserRepository userRepository;

  CreateUseCase({required this.userRepository});

  Future<User> call(User user) async {

    return await userRepository.createUser(user);

  }
  Future<bool> callLogin(AuthUser user) async {
    return await userRepository.login(user);
  }


}

