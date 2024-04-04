import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/bloc/user_bloc.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../../../core/pop_up_messages.dart';
import '../../../bloc/user_event.dart';
import '../login/bloc/login_bloc.dart';

class ButtonNavigationBar extends StatefulWidget {
  const ButtonNavigationBar({Key? key}) : super(key: key);

  @override
  State<ButtonNavigationBar> createState() => _SimpleBottomNavigationState();
}

class _SimpleBottomNavigationState extends State<ButtonNavigationBar> {
  int _selectedIndex = 0;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF1F7774),
      unselectedItemColor: const Color(0xff757575),
      type: _bottomNavType,
      onTap: (index) {
        if (index == 2) {
          Navigator.pushNamed(context, '/profileInfo');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/map');
        }else if (index == 3) {
          showMenu(context);
        }
        setState(() {
          _selectedIndex = index;
        });
      },
      items: _navBarItems,
    );
  }

  void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Déconnexion'),
              onTap: () async {
                //Navigator.pop(context);
                bool shouldUpdate = await showValidationDialog(context, Icons.lock_outline, 'Voulez-vous vous déconnecter?');
                if (shouldUpdate) {
                  BlocProvider.of<UserBloc>(context).add(LogOutEvent());
                  Navigator.pushNamed(context, '/login');
                }
              },
            ),
          ],
        );
      },
    );
  }
}

final _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.map),
    label: 'Map',
  ),
  BottomNavigationBarItem(
    icon: Image(
      image: AssetImage('assets/proile_picture.png'),
      width: 33,
      height: 33,
    ),
    label: 'Profile',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications_outlined),
    activeIcon: Icon(Icons.notifications),
    label: 'Notifications',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu),
    label: 'Plus',
  ),
];