class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String telephone;
  final String establishment;
  final String post;
  final String cin;

  const User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.telephone,
    required this.establishment,
    required this.post,
    required this.cin,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'username': String username,
        'password': String password,
        'email': String email,
        'telephone': String telephone,
        'establishment': String establishment,
        'post': String post,
        'cin': String cin
      } =>
        User(
          id: id,
          username: username,
          password: password,
          email: email,
          telephone: telephone,
          establishment: establishment,
          post: post,
          cin: cin,
        ),
      _ => throw const FormatException(
          'Failed to load User compatible to that Model.'),
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      telephone: map['telephone'],
      establishment: map['establishment'],
      post: map['post'],
      cin: map['cin'],
    );
  }
}
