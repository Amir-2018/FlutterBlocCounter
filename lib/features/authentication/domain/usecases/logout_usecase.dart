
import '../model/auth_user.dart';
import '../repository/user_repository.dart';

class LogOutUseCase {

  final UserRepository userRepository;

  LogOutUseCase({required this.userRepository});

  Future<bool> call() async {
    return  await userRepository.logout();
  }


}

