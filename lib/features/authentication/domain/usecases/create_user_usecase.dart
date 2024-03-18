import 'package:bloc_app/features/authentication/domain/model/auth_user.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';

class CreateUseCase {
  final UserRepository userRepository;

  CreateUseCase({required this.userRepository});

  Future<User> callSignup(User user) async {
    return await userRepository.createUser(user);
  }

  Future<bool> callLogin(AuthUser user) async {
    return await userRepository.login(user);
  }

  Future<String> callGetUser(User user) async {
    return await userRepository.getUser();
  }
}
