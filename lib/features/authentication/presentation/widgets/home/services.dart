import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/home/search_services.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../../../core/widgets/list_annonces_widget.dart';
import '../../../../annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import '../../../../annonces/presentation/list_annonce/list_annonce.dart';
import '../../../../carouselSlides.dart';
import '../subwidgets/button_navigation_bar.dart';

class Services extends StatefulWidget {
  @override
   createState() => _ServicesState();
}
class _ServicesState extends State<Services> {

  List<Map<String, dynamic>> _services = [
    {
      "icon": Icons.map_outlined,
      "title": "Vente & Achat",
      "image": "assets/venteAchat/sale.png",
      "link": "/listVentes"
},
    {"icon": Icons.newspaper_outlined, "title": "Map", "image": "assets/googlemaps.png","link" : "/map"},
    {"icon": Icons.local_convenience_store_rounded, "title": "Conventions", "image": "assets/agreement.png","link" : ""},
    {"icon": Icons.directions_car, "title": "covoiturage", "image": "assets/carService.png","link" : "/listCovoiturages"},
    {"icon": Icons.report_outlined, "title": "Réclamations", "image": "assets/claim.png","link" : "/reclamation"},
    {"icon": Icons.event, "title": "Evenements", "image": "assets/event.png","link" : "/listEvenements"},
  ];
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(textAlign: TextAlign.center, // Center the text horizontally
          'Services',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: const Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white,size: 24),
      ),
      body: Container(
        color: const Color(0xFFEEEEEE),

        child:Column(children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 5,),

                Container(
                  height: 80,
                  padding: const EdgeInsets.all(16.0),
                  child:SearchActualiteInServices()
                  /*TextField(
                    decoration: InputDecoration(
                      hintText: 'Chercher',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),*/
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding:  const EdgeInsets.only(right: 10.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/listAnnoces') ;
                            },
                            child: const Text(
                              'Voir tous',
                              style: TextStyle(color: Color(0xffff0000)),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            color: Color(0xffff0000),
                          )
                        ],
                      )

                    ],
                  ),
                ),

                Container(

                  // padding: const EdgeInsets.only(left: 20, right: 20),
                  color: const Color(0xFFEEEEEE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //const SizedBox(height: 50),

                      BlocProvider<ActualiteBloc>(
                        create: (_) {
                          ActualiteBloc actualiteBloc = getIt<ActualiteBloc>();
                          if (!actualiteBloc.isClosed) {
                            actualiteBloc.add(GetActualitesOfTodays());
                          }
                          return actualiteBloc;
                        },
                        child: Builder(
                          builder: (context) {
                            return BlocBuilder<ActualiteBloc, ActualiteState>(
                              builder: (context, state) {
                                if (state is ListActualiteSuccessOfTodaye) {
                                  return CarouselSliderAnnonce(actualites: state.listactualities);
                                } else if (state is ActualiteLoadingServicesState) {
                                  return const Center(child: CircularProgressIndicator()); // Show a progress indicator
                                }
                                else {
                                  // Handle other states if needed
                                  return Container(); // Placeholder or error message
                                }
                              },
                            );
                          },
                        ),
                      ),
                      /*BlocListener<ActualiteBloc, ActualiteState>(
                          listener: (context, state) {
                            if (state is FilterListActualiteSuccessMessageForServicesState) {
                              //listAnnoces
                              Navigator.pushNamed(context, '/listAnnoces') ;
                            }
                          },
                          child : Container(),
                      ),*/

                      const SizedBox(height: 15),
                      const Text('Explorer nos services',textAlign : TextAlign.center, style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff414141),
                          fontWeight: FontWeight.w500
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _services.map((service) => _buildServiceBox(service)).toList(),
                        ),
                      ),
                      // const SizedBox(height: 33),
                    ],
                  ),
                ),
                //const SizedBox(height: 10,),
              ],
            ),
          ),
          const Expanded(flex : 0,child:  ButtonNavigationBar())
        ],)

      ),
    );
  }

  Widget _buildServiceBox(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, service['link']) ;
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              child: Image.asset(service["image"]),
            ),
            const SizedBox(height: 10),
            Text(
              service["title"],
              style: const TextStyle(fontSize: 13, color: Color(0xff414141)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

