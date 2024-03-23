import '../repository/user_repository.dart';

class VerifyEmailUseCase {
  final UserRepository userRepository;

  VerifyEmailUseCase({required this.userRepository});

  Future<bool> call(String email) async {
    return await userRepository.verifyEmail(email);
  }
}
