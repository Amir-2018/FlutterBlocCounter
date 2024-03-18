import 'dart:convert';
import 'package:bloc_app/features/authentication/data/implementation/user_repository_implementation.dart';
import 'package:bloc_app/features/authentication/domain/model/auth_user.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('Login - User exists', () async {
    final userImplementation = UserImplementation();

    userImplementation.client = MockClient((request) async {
      return http.Response('', 200);
    });

    final user = AuthUser(
      username: "bb",
      email: "test@examplecom",
    );

    // Call the login function
    final result = await userImplementation.login(user);

    // Expect user to exist
    expect(result, true);
  });

  test('Login - Invalid user throws exception', () async {
    final userImplementation = UserImplementation();

    userImplementation.client = MockClient((request) async {
      return http.Response('',
          404); // Suppose que le serveur renvoie une réponse 404 pour un utilisateur invalide
    });

    final user = AuthUser(
      username: "invalid_username",
      email: "invalid@example.com",
    );

    // Call the login function
    expect(() async => await userImplementation.login(user), throwsException);
  });
}
