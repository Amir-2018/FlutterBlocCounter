import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/card_item.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';

import '../../../../core/default_image/default_images.dart';
import '../../../../core/functions/functions.dart';
class ListEvenementsWidget extends StatefulWidget {
  final List<Evenement> evenements;
  ListEvenementsWidget({super.key, required this.evenements});

  @override
  State<StatefulWidget> createState() {
    return _ListEvenementsWidgetState() ;
  }
}

class _ListEvenementsWidgetState extends State<ListEvenementsWidget> {
  static const _pageSize = 4;


  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

   /* _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Encore 4 from ${ListAnnoces.page}') ;

        BlocProvider.of<ActualiteBloc>(context).add(ActualiteGetAllEvent(ListAnnoces.page, _pageSize));
        ListAnnoces.page += 1   ;

        //nreturn CircularProgressIndicator() ;
      }

    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.only(left: 10.0,right : 13.0),
        color: const Color(0xffEEEEEE),
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
                    itemCount: widget.evenements.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(widget.evenements[index].photo);

                      return Column(
                        children: [
                          Column(
                            children: [
                              CardItem(
                                imageUrl: GetIt.I.get<Functions>().decodeBase64String(ANNONCEImage),
                                title: widget.evenements[index].titre!,
                                description: widget.evenements[index].description, onPressedCallback: () {
                                Navigator.pushNamed(context, '/postWidget', arguments: {
                                  'photo':GetIt.I.get<Functions>().decodeBase64String(ANNONCEImage),
                                  'title': widget.evenements[index].titre,
                                  'date_debut': widget.evenements[index].date_debut,
                                  'date_fin': widget.evenements[index].date_fin,
                                  'description': widget.evenements[index].description,
                                });
                              },
                              ),
                              const SizedBox(height: 5,),
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