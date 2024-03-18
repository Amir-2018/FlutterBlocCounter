import 'dart:convert';

import 'package:bloc_app/features/authentication/data/implementation/user_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Testing the network call ', () async {
    final userImplementation = UserImplementation();
    userImplementation.client = MockClient((request) async {
      return Response(json.encode({'email': 'amir@gmail.com'}), 200);
    });

    final emailUser = await userImplementation.getUser();
    expect(emailUser, 'Sincere@april.biz');
  });
}
