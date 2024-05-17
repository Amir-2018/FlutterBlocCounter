import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/card_item.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';

import '../../../../core/functions/functions.dart';
import '../../domain/model/vente.dart';
import 'bloc/vente_bloc.dart';

class ListVentesWidget extends StatefulWidget {
  final List<Vente> ventes;
  final String titre;
  ListVentesWidget({super.key, required this.ventes,required this.titre});

  @override
  State<StatefulWidget> createState() {
    return _ListAnnocesWidgetState() ;
  }
}

class _ListAnnocesWidgetState extends State<ListVentesWidget> {
  static const _pageSize = 4;


  ScrollController _scrollController = ScrollController();
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      debugPrint('Encore 4 from ${ListVentes.page}') ;
      BlocProvider.of<VenteBloc>(context).add(VenteGetAllEvent(ListVentes.page, _pageSize));

      //nreturn CircularProgressIndicator() ;
    }

  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.only(left: 10.0,right : 13.0),
        color: const Color(0xffF5F5F5),
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
                    itemCount: widget.ventes.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(widget.ventes[index].photo);

                      return Column(
                        children: [
                          Column(
                            children: [
                              CardItem(
                                imageUrl: GetIt.I.get<Functions>().decodeBase64String('widget.listVentes[index].photo!'),
                                title: widget.ventes[index].titre,
                                description: widget.ventes[index].description, onPressedCallback: () {
                                Navigator.pushNamed(context, '/postWidget', arguments: {
                                  'imageUrl': 'assets/news.jpg',
                                  'title': widget.ventes[index].titre,
                                  'date': widget.ventes[index].date,
                                  'description': widget.ventes[index].description,
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