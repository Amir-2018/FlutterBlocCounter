import 'dart:convert';
import 'package:bloc_app/features/authentication/data/implementation/user_repository_implementation.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Return user if test passed with successs ', () async {
    final userImplementation = UserImplementation();
    const expectedUser =
        User(id: 22, name: "amir", username: "amirch", email: "amir@gmail.com");
    userImplementation.client = MockClient((request) async {
      return Response(json.encode(expectedUser.toJson()), 201);
    });

    final user = await userImplementation.createUser(expectedUser);
    expect(user.name, expectedUser.name);
    expect(user.username, expectedUser.username);
    expect(user.email, expectedUser.email);
  });

  test('Handle error if user creation fails', () async {
    final userImplementation = UserImplementation();
    const expectedUserData = <String, dynamic>{
      "name": 12,
      "username": "amirch",
      "email": "amir@gmail.com",
    };
    final expectedUser = User.fromJson(expectedUserData);

    // Create a MockClient that returns an error response
    userImplementation.client = MockClient((request) async {
      return Response(
          json.encode(
              {'error': 'Failed to load User compatible to that Model'}),
          400);
    });

    // Call the createUser method
    final user = await userImplementation.createUser(expectedUser);

    // Assert that the returned user is null, indicating failure
    expect(user, null);
  });
}
