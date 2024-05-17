import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../../../core/connection_management.dart';
import '../../../../core/constantes.dart';
import '../../../../core/dependencies_injection.dart';
import '../../domain/model/auth_user.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/user_repository.dart';
import '../../../../core/database/database_helper.dart';

class UserRepositoryImpl extends UserRepository {
   //http.Client client = http.Client();

  String accessToken = '';
  @override
  Future<bool> login(AuthUser authUser) async {
    initDependencies();
    try {
      final response = await http.post(
        Uri.parse(TOKEN_AUTH_LINK),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          'client_id': 'login-app',
          'username': authUser.username,
          'password': authUser.password,
          'grant_type': 'password'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        accessToken = data['access_token'];

        await getIt<FlutterSecureStorage>().write(key: "access_token", value: accessToken);
        return true;
      } else if (response.statusCode == 404) {
        debugPrint("User not found");
        return false;
      } else if (response.statusCode == 401) {
        debugPrint("Utilisateur n'est pas autorisé");
        return false;
      } else {
        throw Exception('Failed to check user existence.');
      }
    } catch (e) {
      throw Exception('Failed to check user existence: $e');
    }
  }

  @override
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$LINK/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //'id': 100,
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'telephone': user.telephone,
        'establishment': user.establishment,
        'post': user.post,
        'cin': user.cin
      }),
    );
    if (response.statusCode == 201) {
      try {} catch (err) {
        debugPrint('There is some error here $err');
      }
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception('Failed to create User. ');
    }
  }

  @override
  Future<bool> verifyEmail(String userEmail) async {
    try {
      final response = await http.post(
        Uri.parse('$LINK/verifyEmail'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          'client_id': 'login-app',
          'email': userEmail,
          'grant_type': 'password'
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        debugPrint("Password has been sent with success");
        return false;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to send emaill');
      }
    } catch (e) {
      throw Exception('Failed to check email existence: $e');
    }
  }

  @override
  Future<bool> changePassword(String password) async {
    try {
      final response = await http.post(
        Uri.parse('link/changePassword'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          'client_id': 'login-app',
          'password': password,
          'grant_type': 'password'
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        debugPrint("Email have been sent with success");
        return false;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to send emaill');
      }
    }
    catch (e) {
      throw Exception('Failed to check email existence: ${e}');
    }
  }

  @override
  Future<User> getUserInfo(String username) async {
    // Handle Connection error
    bool isConnected = await checkConnection(); // Vérifier la connexion
    // Mode connecté
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();
    if (isConnected) {
      String? value = await getIt<FlutterSecureStorage>().read(key: 'access_token');
      final response = await http.get(
        Uri.parse('$LINK/user/$username'),
        headers: {
          'Authorization': 'Bearer $value',
        },
      );
      debugPrint('check this response${(response.statusCode).toString()}');
      if (response.statusCode == 200) {
        User userInfo = User.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);

        List<User> users = await databaseHelper.getUsers();
        bool userExists = users.any((user) => user.id == userInfo.id);
        if (userExists) {
          debugPrint(
              'User with ID ${userInfo.id} already exists in the database.');
          for (User user in users) {
            debugPrint('User ID: ${user.id}');
            debugPrint('Username: ${user.username}');
            debugPrint('Email: ${user.email}');
          }
          databaseHelper.closeDatabase();
          return userInfo;
        } else {
          debugPrint("User n'esxiste pas");
          await databaseHelper.insertUser(userInfo);
          List<User> users = await databaseHelper.getUsers();
          User user = users[0];
          databaseHelper.closeDatabase();
          return user;
        }
      }
      else {
        debugPrint('Error fetching data: $response');
        debugPrint('Check this ${response.statusCode}');
        throw Exception('Failed to get user info: ${response.statusCode}');

        // Mode déconnecté  : Communication avec la base de donnée locale
      }
    }
    else {
      debugPrint('Communication avec la base de données locale');
      List<User> users = await getIt<DatabaseHelper>().getUsers();
      if (users.isNotEmpty) {
        return users[0];
      } else {
        debugPrint('You have to connect to your internet');
        throw Exception('User not found');
      }
    }
  }

  @override
  Future<bool> logout() async {
    DatabaseHelper databaseHelper = GetIt.I<DatabaseHelper>();
    await databaseHelper.initializeDatabase();

    bool usersDeleted = await databaseHelper.deleteAllUsers();
    if (usersDeleted) {
      bool disconnect = await deleteTokenFromStorage();
      if (disconnect) {
        debugPrint('I have deleted the token');
        return true;
      }
    }
    databaseHelper.closeDatabase();
    return false;
  }

  @override
  Future<bool> updateUser(String username, User user) async {
    String? value = await getIt<FlutterSecureStorage>().read(key: 'access_token');

    final response = await http.patch(
      Uri.parse('$LINK/user/$username'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $value',
      },
      body: jsonEncode(user.toMap()),
    );
    if (response.statusCode == 200) {
      debugPrint('User Updated with success') ;
      return true; // Update successful, return true
    } else {
      throw Exception('Failed to update User.');
    }
  }
}
