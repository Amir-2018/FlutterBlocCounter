import 'dart:convert';
import 'package:bloc_app/features/authentication/data/implementation/user_repository_implementation.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('return success if the user is successfully created', () async {
    // Create an instance of UserImplementation
    final userImplementation = UserImplementation();

    // Mock the HTTP client
    final mockClient = MockClient();
    userImplementation.client = mockClient;

    // Define the expected user
    const expectedUser = User(
      id: 12,
      name: 'aa',
      username: 'aa',
      email: 'test@examplecom',
    );

    // Mock the post request and response
    when(mockClient.post(Uri.parse('http://localhost:3000/users/'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(
            json.encode({
              'id': 1,
              'name': 'amir',
              'username': 'mirou',
              'email': 'amir@gmail.com'
            }),
            200));

    // Call the createUser method
    final userCreated = await userImplementation.createUser(expectedUser);

    // Assert that the created user matches the expected user
    expect(userCreated, expectedUser);
  });
}
