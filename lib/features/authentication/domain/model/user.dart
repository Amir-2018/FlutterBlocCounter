class User {
  final int? id;
  final String name;
  final String username;
  final String email;

  const User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'username': String username,
        'email': String email,
      } =>
        User(id: id, name: name, username: username, email: email),
      _ => throw const FormatException(
          'Failed to load User compatible to that Model.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email}';
  }
}
