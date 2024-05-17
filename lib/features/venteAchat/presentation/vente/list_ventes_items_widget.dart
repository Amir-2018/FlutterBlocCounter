import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/card_item.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/bloc/vente_bloc.dart';

import '../../../../core/functions/functions.dart';
import '../../domain/model/vente.dart';
class ListVentesItemsWidget extends StatefulWidget {
  final List<Vente> listVentes;
  final String titre;
  ListVentesItemsWidget({super.key, required this.listVentes,required this.titre});

  @override
  State<ListVentesItemsWidget> createState() {
    return _ListVentesItemsWidgetState() ;
  }
}

class _ListVentesItemsWidgetState extends State<ListVentesItemsWidget> {
  static const _pageSize = 4;


  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Encore 4 from ${ListVentes.page}') ;

        BlocProvider.of<VenteBloc>(context).add(VenteGetAllEvent(ListVentes.page, _pageSize));
        ListVentes.page += 1   ;

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
              const SizedBox(height: 15,),

              Expanded(
                flex: 5,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child:

                  ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.listVentes.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(widget.listVentes[index].photo);

                      return Column(
                        children: [
                          Column(
                            children: [
                              CardItem(
                                imageUrl: GetIt.I.get<Functions>().decodeBase64String(widget.listVentes[index].photo!),
                                title: widget.listVentes[index].titre,
                                description: widget.listVentes[index].description,
                                onPressedCallback: () {
                                Navigator.pushNamed(context, '/detailesVentes', arguments: {

                                  'titre': widget.listVentes[index].titre,
                                  'date': widget.listVentes[index].date,
                                  'prix': widget.listVentes[index].prix,
                                  'photo':GetIt.I.get<Functions>().decodeBase64String(widget.listVentes[index].photo!),
                                  'type': widget.listVentes[index].type,

                                  'description': widget.listVentes[index].description,
                                  'quantite': widget.listVentes[index].quantite,
                                  'contact': widget.listVentes[index].contact,
                                  'objet': widget.listVentes[index].objet,

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