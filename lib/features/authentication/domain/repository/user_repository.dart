import 'package:bloc_app/features/authentication/domain/model/auth_user.dart';

import '../model/user.dart';

abstract class UserRepository {
  Future<String> getUser();
  Future<User> createUser(User user);
  Future<User> updateUser(User user);
  Future<void> insertUser(User user);
  Future<bool> login(AuthUser user);
}
