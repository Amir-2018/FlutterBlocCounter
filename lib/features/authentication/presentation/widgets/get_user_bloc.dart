/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/implementation/user_repository_implementation.dart';

class GetUserBloc extends StatelessWidget {
  const GetUserBloc({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('The BloC App')),
        body: BlocProvider<UserBloc>(
          create: (context) => UserBloc(UserImplementation())
            ..add(
              LoadUserEvent(),
            ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is InitialUserLoadedState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserErrorState) {
                return const Center(
                    child: Text(
                  "Failed to load user",
                  style: TextStyle(fontSize: 50),
                ));
              }
              if (state is UserLoadedState) {
                return Center(
                  child: Text(
                    state.user.email.toString(),
                    style: const TextStyle(fontSize: 50),
                  ),
                );
              }

              return Container();
            },
          ),
        ));
  }
}
*/