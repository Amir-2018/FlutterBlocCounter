import 'dart:convert';
import 'package:bloc_app/features/authentication/domain/repository/user_repository.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;

class UserImplementation extends UserRepository {
  Future<User> getUser() async {
    final response = await http.get(Uri.parse('http://localhost:3000/users/2'));
    if (response.statusCode == 200) {
      User user =
          User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'username': user.username,
        'email': user.email
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create User.');
    }
  }
}
