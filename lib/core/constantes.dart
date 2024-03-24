import 'package:bloc_app/features/authentication/domain/model/user.dart';

const LINK = 'http://localhost:8000/users';

const String TOKEN_AUTH_LINK =
    'http://172.19.0.55:8080/realms/SpringBootKeycloak/protocol/openid-connect/token';

const String HOST_ADDRESS = 'http://localhost:8000';

const User EMPTY_USER = User(
  cin: 'empty',
  username: 'empty',
  password: 'empty',
  email: 'empty',
  telephone: 'empty',
  establishment: 'empty',
  post: 'empty',
);
