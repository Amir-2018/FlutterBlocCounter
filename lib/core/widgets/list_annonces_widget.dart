import 'package:dio_cache_interceptor_objectbox_store/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pfechotranasmartvillage/core/widgets/card_item.dart';
import 'package:pfechotranasmartvillage/core/widgets/search_field.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/model/actualite.dart';
import '../../features/annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import '../../features/annonces/presentation/list_annonce/list_annonce.dart';
import '../../features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import '../functions/functions.dart';
class ListAnnocesWidget extends StatefulWidget {
  final List<Actualite> annonces;
  final String titre;
  ListAnnocesWidget({super.key, required this.annonces,required this.titre});

  @override
  State<StatefulWidget> createState() {
    return _ListAnnocesWidgetState() ;
  }
}

class _ListAnnocesWidgetState extends State<ListAnnocesWidget> {
  static const _pageSize = 4;


  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        debugPrint('Encore 4 from ${ListAnnoces.page}') ;

        BlocProvider.of<ActualiteBloc>(context).add(ActualiteGetAllEvent(ListAnnoces.page, _pageSize));
        ListAnnoces.page += 1   ;

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
                    itemCount: widget.annonces.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(widget.annonces[index].photo);

                      return Column(
                        children: [
                          Column(
                            children: [
                              CardItem(
                                imageUrl: GetIt.I.get<Functions>().decodeBase64String(widget.annonces[index].photo!),
                                title: widget.annonces[index].titre,
                                description: widget.annonces[index].description,
                                onPressedCallback: () {
                                Navigator.pushNamed(context, '/postWidget', arguments: {
                                  'photo':GetIt.I.get<Functions>().decodeBase64String(widget.annonces[index].photo!),
                                  'title': widget.annonces[index].titre,
                                  'date': widget.annonces[index].date,
                                  'description': widget.annonces[index].description,
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