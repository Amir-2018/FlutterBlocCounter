import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../core/constantes.dart';
import '../../../../core/dependencies_injection.dart';
import '../../domain/model/auth_user.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/local/database_helper.dart';

class UserRepositoryImpl extends UserRepository {
  // Instance defined for test to mock objects
  Client client = Client();
  // Inject the databas helper to manage sqllite
  // Initialize database
  final storage = new FlutterSecureStorage();

  @override
  Future<bool> login(AuthUser authUser) async {
    try {
      final response = await http.post(
        Uri.parse(TOKEN_AUTH_LINK),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        //encoding: Encoding.getByName('utf-8'),
        body: {
          'client_id': 'login-app',
          'username': authUser.username,
          'password': authUser.password,
          'grant_type': 'password'
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        String accessToken = '';
        accessToken = data['access_token'];
        await storage.write(key: "access_token", value: accessToken);
        return true;
      } else if (response.statusCode == 404) {
        debugPrint("User not found");
        return false;
      } else if (response.statusCode == 401) {
        debugPrint("Utilisateur n'est pas autorisé ");
        return false;
      }
      else {
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
      try {
        initDependencies();
        getIt<DatabaseHelper>().initializeDatabase();
        // getIt<DatabaseHelper>().getUsers();
      } catch (err) {
        debugPrint('There is some error here $err');
      }
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception('Failed to create User. ');
    }
  }

  @override
  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$LINK/update/username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': '2',
        'name': "Amir",
        'username': "Mirou12",
        'email': "Amir@gmail.com"
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception('Failed to create User.');
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
  DatabaseHelper databsaseHelper = DatabaseHelper() ;

  @override
  Future<User> getUserInfo(String username) async {
    await databsaseHelper.initializeDatabase() ;
    String? value = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$LINK/user/$username'),
      headers: {
        'Authorization': 'Bearer $value',
      },
    );
    debugPrint((response.statusCode).toString());
    if (response.statusCode == 200) {

      User userInfo =  User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return userInfo ;
      return json.decode(response.body);
    }

    else {
      /*debugPrint('Error fetching data: $response');
      debugPrint('Check this ${response.statusCode}');
      throw Exception('Failed to get user info: ${response.statusCode}');*/

      Map<dynamic, dynamic>? userData = await databsaseHelper.getFirstUser();
      if (userData != null) {
        User user = User.fromMap(userData);
        debugPrint('The user is $user') ;
        return user ;
      } else {
        throw Exception('User not found');
      }
    }
  }
}
