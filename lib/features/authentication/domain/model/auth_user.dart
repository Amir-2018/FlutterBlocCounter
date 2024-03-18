class AuthUser {
  final String username;
  final String email;

  const AuthUser({
    required this.username,
    required this.email,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'email': String email,
      } =>
        AuthUser(username: username, email: email),
      _ => throw const FormatException('Problem with auth user'),
    };
  }
}
