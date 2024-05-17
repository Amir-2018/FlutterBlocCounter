import 'package:flutter/material.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/list_ventes/list_ventes.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/bloc/vente_bloc.dart';

import '../../../../core/dependencies_injection.dart';
import '../../data/implementation/vente_achat_repository_impl.dart';
import '../../domain/usecases/get_list_ventes_by_title_usecase.dart';
import '../../domain/usecases/get_list_ventes_usecase.dart';
import '../../domain/usecases/insert_vente_usecase.dart';


class VenteSearchFieldAll extends StatelessWidget {
  const VenteSearchFieldAll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Example'),
        ),
        body: const VenteSearchField(),
      ),
    );
  }
}
class VenteSearchField extends StatefulWidget{
  static  List<String> options = <String>[

  ];
  const VenteSearchField({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutocompleteBasicExampleState() ;
  }

}

class _AutocompleteBasicExampleState extends State<VenteSearchField> {

  @override
  void initState() {
    if (!getIt.isRegistered<VenteBloc>()) {
      getIt.registerLazySingleton<VenteBloc>(
            () => VenteBloc(InsertVenteUsecase(
            venteRepository: VenteAchatRepositoryImpl()),GetListVentesUsecase(venteRepository: VenteAchatRepositoryImpl()),GetListVentesByTitleUsecase(venteRepository: VenteAchatRepositoryImpl())),
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
                return VenteSearchField.options
                    .where((option) =>
                    option.toLowerCase().contains(textEditingValue.text.toLowerCase()))
                    .toSet()
                    .toList();
              },
              onSelected: (String selection) {
                VenteBloc venteBloc = getIt<VenteBloc>();
                if (!venteBloc.isClosed) {

                  // ListAnnoces.actulitesList.clear() ;
                  // print('I will send with ${ListVentes.pageSearch}') ;
                  venteBloc.add(GetVentesByTitle(ListVentes.pageSearch,ListVentes.pageSize,selection));
                  debugPrint('La liste des vesntes est${ListVentes.pageSearch}') ;
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
              VenteBloc venteBloc = getIt<VenteBloc>() ;
              if (!venteBloc.isClosed) {
                // ListAnnoces.actulitesList.clear() ;
                ListVentes.ventListes.clear() ;
                ListVentes.page  = 0  ;

                venteBloc.add(VenteGetAllEvent(ListVentes.page,ListVentes.pageSize));
                ListVentes.page += 1  ;
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