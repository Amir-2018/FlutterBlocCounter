import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';

import '../../../../core/connection_bar.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../bloc/user_bloc.dart';
import '../../bloc/user_event.dart';
import '../../bloc/user_state.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    initDependencies();

    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<UserBloc>(
          create: (context) => getIt<UserBloc>()..add(UserInfoEventInitial()),
        ),
      ], child: const ProfileInfoWidget()),
    );
  }
}

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                      if (state is UserSuccessState) {
                        return Column(
                          children: [
                            Text(
                              state.userObject.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text(
                                textAlign: TextAlign.center,
                                state.userObject.post,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 16),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.email_outlined),
                                      )),
                                      Center(
                                        child: Text(
                                          state.userObject.email,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.phone_outlined),
                                      )),
                                      Center(
                                        child: Text(state.userObject.telephone),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                            Icons.business_center_outlined),
                                      )),
                                      Center(
                                        child: Text(
                                          state.userObject.establishment,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.credit_card_outlined),
                                      )),
                                      Center(
                                        child: Text(state.userObject.cin),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.business_sharp),
                                      )),
                                      Center(
                                        child: Text(
                                            state.userObject.establishment),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock_outline),
                                      )),
                                      Center(
                                        child: Text(state.userObject.password),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (state is UserFailedState) {
                        return const Text('error message',
                            style: TextStyle(
                                color: Color.fromARGB(255, 77, 86, 78)));
                      } else {
                        return Container();
                      }
                    }),
                    //Column(chi)

                    const SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {},
                          heroTag: 'follow',
                          elevation: 0,
                          backgroundColor: const Color(0xFF1F7774),
                          label: const Text(
                            "Manage Events",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          heroTag: 'Verify',
                          elevation: 0,
                          backgroundColor: const Color(0xff607274),
                          label: const Text(
                            "Verify",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    //const _ProfileInfoRow()
                  ],
                ),
              ),
            ),
          ),
          const ButtonNavigationBar()
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF1F7774), Color(0xFF1F7774)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    //color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/proile_picture.png')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Color(0xff5D805E), shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF5F0E3), width: 2),
              color: const Color(0xFF1F7774),
              shape: BoxShape.circle,
            ),
            //padding: EdgeInsets.only(right: 20,top :50),
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                bool isConnected =
                    await checkConnection(); // Vérifier la connexion

                if (!isConnected) {
                  showConnectionFailedPopup(context);
                } else {
                  Navigator.pushNamed(context, '/update_profile');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
