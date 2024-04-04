import '../model/auth_user.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<User> createUser(User user);
  Future<bool> updateUser(String username,User user);
  Future<bool> login(AuthUser user);
  Future<bool> verifyEmail(String email);
  Future<bool> changePassword(String password);
  Future<User> getUserInfo(String username);
  Future<bool> logout();

}
