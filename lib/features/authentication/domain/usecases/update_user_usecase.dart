
import '../model/auth_user.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

class UpdateUseCase {

  final UserRepository userRepository;

  UpdateUseCase({required this.userRepository});

  Future<bool> call(String username,User user) async {
    return  await userRepository.updateUser(username, user);
  }


}

