import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependencies_injection.dart';
import '../../../../../core/widgets/search_field.dart';
import '../../../../annonces/data/implementation/actualite_repo_impl.dart';
import '../../../../annonces/domain/usecases/get_actualities_of_today_usecase.dart';
import '../../../../annonces/domain/usecases/get_list_actualities_by_title_usecase.dart';
import '../../../../annonces/domain/usecases/get_list_actualities_usecase.dart';
import '../../../../annonces/domain/usecases/insert_actualitie_usecase.dart';
import '../../../../annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import '../../../../annonces/presentation/list_annonce/list_annonce.dart';



class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Example'),
        ),
        body: const SearchActualiteInServices(),
      ),
    );
  }
}
class SearchActualiteInServices extends StatefulWidget{
  static  List<String> options = <String>[

  ];
  const SearchActualiteInServices({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutocompleteBasicExampleState() ;
  }

}

class _AutocompleteBasicExampleState extends State<SearchActualiteInServices> {

  @override
  void initState() {
    if (!getIt.isRegistered<ActualiteBloc>()) {
      getIt.registerLazySingleton<ActualiteBloc>(
            () =>
            ActualiteBloc(InsertActualityUsecase(
                actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecase(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecaseByTitle(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesOfTodayeUsecase(actualiteRepository: ActualiteRepositoryImpl())),
      );
    }
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    String textEditingValueToSearch;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.transparent, // Set shadow color to transparent
                offset: Offset(0, 0), // Set horizontal and vertical offset to 0
                blurRadius: 0, // Set blur radius to 0
                spreadRadius: 0, // Set spread radius to 0
              ),
            ],
          ),
          child: BlocListener<ActualiteBloc, ActualiteState>(
            listener: (context, state) {
              if (state is ActualiteMakeTexFieldEmptyState) {

                //Autocomplete. = '';


              }
            },
            child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  textEditingValueToSearch = textEditingValue.text ;
                  return AutocompleteBasicExample.options
                      .where((option) =>
                      option.toLowerCase().contains(textEditingValue.text.toLowerCase()))
                      .toSet()
                      .toList();
                },
                onSelected: (String selection) {
                    Navigator.pushNamed(context, '/listAnnoces', arguments: {
                      'selection': selection,
                    });

                }
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
             /* getIt<ActualiteBloc>().add(MakeTexFieldEmptyEvent()) ;
              ActualiteBloc actualiteBloc = getIt<ActualiteBloc>() ;
              if (!actualiteBloc.isClosed) {
                ListAnnoces.actulitesList.clear() ;
                // ListAnnoces.searchList.clear() ;
                ListAnnoces.page = 0  ;
                actualiteBloc.add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
              } else {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }*/
            },
          ),
        ),


      ],
    );
  }
}