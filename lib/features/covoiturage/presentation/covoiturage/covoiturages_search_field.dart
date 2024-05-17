import 'package:flutter/material.dart';
import 'package:pfechotranasmartvillage/features/covoiturage/presentation/list_covoiturages/list_covoiturage.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/bloc/vente_bloc.dart';

import '../../../../core/dependencies_injection.dart';
import '../../data/implementation/covoiturage_repo_impl.dart';
import '../../domain/usecases/get_list_covoiturages_by_title_usecase.dart';
import '../../domain/usecases/get_list_covoiturages_usecase.dart';
import '../../domain/usecases/insert_covoiturage_usecase.dart';
import '../actaulitie/bloc/covoiturage_bloc.dart';


class CovoituragesSearchFieldAll extends StatelessWidget {
  const CovoituragesSearchFieldAll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Example'),
        ),
        body: const CovoiturageSearchField(),
      ),
    );
  }
}
class CovoiturageSearchField extends StatefulWidget{
  static  List<String> options = <String>[

  ];
  const CovoiturageSearchField({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutocompleteBasicExampleState() ;
  }

}

class _AutocompleteBasicExampleState extends State<CovoiturageSearchField> {

  @override
  void initState() {
    if (!getIt.isRegistered<CovoiturageBloc>()) {
      getIt.registerLazySingleton<CovoiturageBloc>(
            () =>
            CovoiturageBloc(InsertCovoiturageUsecase(
                covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecase(covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecaseByTitle(covoiturageRepository: CovoiturageRepositoryImpl())),
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
          child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                textEditingValueToSearch = textEditingValue.text ;
                return CovoiturageSearchField.options
                    .where((option) =>
                    option.toLowerCase().contains(textEditingValue.text.toLowerCase()))
                    .toSet()
                    .toList();
              },
              onSelected: (String selection) {
                CovoiturageBloc covoiturageBloc = getIt<CovoiturageBloc>();
                if (!covoiturageBloc.isClosed) {

                  // ListAnnoces.actulitesList.clear() ;
                  // print('I will send with ${ListVentes.pageSearch}') ;
                  covoiturageBloc.add(GetCovoituragesByTitleEvent(ListCovoiturages.pageSearch,ListCovoiturages.pageSize,selection));
                }
                debugPrint('You just selected $selection');

              }
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              CovoiturageBloc covoiturageBloc = getIt<CovoiturageBloc>() ;
              if (!covoiturageBloc.isClosed) {
                // ListAnnoces.actulitesList.clear() ;
                ListVentes.ventListes.clear() ;
                ListVentes.page  = 0  ;

                covoiturageBloc.add(CovoiturageGetAllEvent(ListCovoiturages.page,ListCovoiturages.pageSize));
                ListCovoiturages.page += 1  ;
              } else {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}