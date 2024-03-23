import '../model/user.dart';
import '../repository/user_repository.dart';

class GestUserInfoUseCase {
  final UserRepository userRepository;

  GestUserInfoUseCase({required this.userRepository});

  Future<User> call(String username) async {
    return await userRepository.getUserInfo(username);
  }
}
