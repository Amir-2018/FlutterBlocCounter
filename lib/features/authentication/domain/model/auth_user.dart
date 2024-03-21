class AuthUser {
  final String username;
  final String password;

  const AuthUser({
    required this.username,
    required this.password,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'username': String username, 'password': String password} =>
        AuthUser(username: username, password: password),
      _ => throw const FormatException('Problem with auth user'),
    };
  }
}
