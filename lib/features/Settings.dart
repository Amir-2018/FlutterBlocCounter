import 'package:flutter/material.dart';
import 'authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';

class SO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFEEEEEE),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(color: Color(0xff7FB77E)),
                  flex: 2,
                ),
                Expanded(
                  child: Container(color: Colors.transparent),
                  flex: 5,
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    title: Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    subtitle: Text(
                      'Suivre vos actions',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 70,
                      height: 70,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/profileInfo') ;
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person_outline, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: GridView.count(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                        childAspectRatio: .90,
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/venteAchat/sale.png', height: 64),
                                  SizedBox(height: 8),
                                  Text('Vente & Achat')
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/megaphone.png', height: 64),
                                  SizedBox(height: 8),
                                  Text('Actualités')
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/dashEvents') ;
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/event.png', height: 64),
                                    SizedBox(height: 8),
                                    Text('Evenements')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/carService.png', height: 64),
                                  SizedBox(height: 8),
                                  Text('covoiturage')
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/claim.png', height: 64),
                                  SizedBox(height: 8),
                                  Text('Réclamations')
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/event.png', height: 64),
                                  SizedBox(height: 8),
                                  Text('Evenements')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 0, child: ButtonNavigationBar()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}