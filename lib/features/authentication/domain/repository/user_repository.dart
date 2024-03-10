import '../model/user.dart';

abstract class UserRepository {
  Future<User> getUser();

  Future<User> createUser(User user);
}
