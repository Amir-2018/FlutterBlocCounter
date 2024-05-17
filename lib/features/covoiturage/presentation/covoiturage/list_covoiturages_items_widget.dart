import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/card_item.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/domain/model/covoiturage_model.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/presentation/actaulitie/bloc/covoiturage_bloc.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/presentation/list_covoiturages/list_covoiturage.dart';

import '../../../../core/functions/functions.dart';
import 'card_item_covoiturages.dart';
class ListCovoituragesItemsget extends StatefulWidget {
  final List<CovoiturageModel> covoiturages;
  final String titre;
  ListCovoituragesItemsget({super.key, required this.covoiturages,required this.titre});

  @override
  State<StatefulWidget> createState() {
    return _ListCovoituragesItemsgetState() ;
  }
}

class _ListCovoituragesItemsgetState extends State<ListCovoituragesItemsget> {
  static const _pageSize = 4;


  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Encore 4 from ${ListCovoiturages.page}') ;

        BlocProvider.of<CovoiturageBloc>(context).add(CovoiturageGetAllEvent(ListCovoiturages.page, _pageSize));
        ListCovoiturages.page += 1   ;

        //nreturn CircularProgressIndicator() ;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.only(left: 10.0,right : 13.0),
        color: const Color(0xffD9D9D9),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),

              Expanded(
                flex: 5,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child:

                  ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.covoiturages.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(widget.covoiturages[index].photo);

                      return Column(
                        children: [
                          Column(
                            children: [
                              CardItemCovoiturage(
                                imageUrl: 'assets/covoiturages/covoiturage.png',
                                title: widget.covoiturages[index].titre,
                                description: widget.covoiturages[index].description, onPressedCallback: () {
                                Navigator.pushNamed(context, '/detailesCovoiturage', arguments: {
                                  //'imageUrl': 'assets/news.jpg',
                                  'depart': widget.covoiturages[index].depart,
                                  'destination': widget.covoiturages[index].destination,
                                  'description': widget.covoiturages[index].description,
                                  'nb_personnes': widget.covoiturages[index].nb_personnes,
                                  'temps_depart': widget.covoiturages[index].temps_depart,
                                  'photo': widget.covoiturages[index].photo,
                                  'cotisation': widget.covoiturages[index].cotisation,
                                  'contact': widget.covoiturages[index].contact,
                                  'type': widget.covoiturages[index].type,
                                  'titre': widget.covoiturages[index].titre,
                                  'date': widget.covoiturages[index].date,
                                });
                              },
                              ),
                              const SizedBox(height: 15,),
                            ],
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}