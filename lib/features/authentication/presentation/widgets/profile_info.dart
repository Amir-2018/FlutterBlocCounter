import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  Text(
                    "Richie Lorie",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                      textAlign: TextAlign.center,
                      "I am jhon doe and i am software engineerat Actia Engineering Services",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.maps_ugc_outlined),
                            )),
                            Center(
                              child: Text('Sfax sakiet ezzit 2024'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.email_outlined),
                            )),
                            Center(
                              child: Text('Jhon.Doe@actia-engineering.tn'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.call_outlined),
                            )),
                            Center(
                              child: Text('+216 412 325 698'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person_2_outlined),
                            )),
                            Center(
                              child: Text('Technical lead'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                          ),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  //const _ProfileInfoRow()
                ],
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
            margin: EdgeInsets.only(top: 10, right: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffF5F0E3), width: 2),
              color: Color(0xFF1F7774),
              shape: BoxShape.circle,
            ),
            //padding: EdgeInsets.only(right: 20,top :50),
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/update_profile');
              },
            ),
          ),
        ),
      ],
    );
  }
}
