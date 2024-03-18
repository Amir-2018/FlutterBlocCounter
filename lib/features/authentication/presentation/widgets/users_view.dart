/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/model/user.dart';
import '../../domain/repository/user_repository.dart';

class Users_view extends StatefulWidget {
  const Users_view({super.key});

  @override
  State<Users_view> createState() => _MyAppState();
}

class _MyAppState extends State<Users_view> {
  late Future<User> futureUser;
  late UserRepository repo_user;
  @override
  void initState() {
    super.initState();
    futureUser = repo_user.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
*/