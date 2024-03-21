
import '../model/auth_user.dart';
import '../repository/user_repository.dart';

class LoginUserUseCase {

  final UserRepository userRepository;

  LoginUserUseCase({required this.userRepository});

  Future<bool> call(AuthUser authUser) async {
    return await userRepository.login(authUser);
  }


}

