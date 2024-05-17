import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/usecases/delete_evenement_usecase.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/usecases/insert_evenement_usecase.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/widgets/list_annonces_widget.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../authentication/domain/model/user.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../data/implementation/event_repository_impl.dart';
import '../../domain/usecases/get_evenements_by_username_usecase.dart';
import '../../domain/usecases/update_evenement_usecase.dart';
import '../event/bloc/evenement_bloc.dart';
import 'lis_evenements_widget.dart';

class ListEvenements extends StatefulWidget {
  static List<Evenement> evenementList = [] ;
  static int lengthevEnementList = evenementList.length ;
  static List<Evenement>  evenementsearchList = [] ;
  static  int page = 0 ;
  static  int pageSize = 10 ;
  static List<Evenement> evenementListTest = const [

  ] ;

  const ListEvenements({Key? key}) : super(key: key);

  @override
  _ListAnnocesState createState() => _ListAnnocesState();
}

class _ListAnnocesState extends State<ListEvenements> {
  @override
  void initState() {

    if (!getIt.isRegistered<EvenementBloc>()) {
      getIt.registerLazySingleton<EvenementBloc>(
            () =>
            EvenementBloc( InsertEvenementUsecase(evenementRepository: EventRepositoryImpl()),GestEvenementsByUsernameUsecase(evenementRepository: EventRepositoryImpl()),DeleteEvenementUsecase(evenementRepository: EventRepositoryImpl()),UpdateEvenementUsecase(evenementRepository: EventRepositoryImpl())),
      );
    }
    ListEvenements.evenementList.clear();
    ListEvenements.page = 0;
    //ActualiteBloc actualiteBloc =  getIt<ActualiteBloc>();
    //actualiteBloc.add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          FutureBuilder<bool>(
            future: getIt<Functions>().verifyTokenExistence(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Visibility(
                  visible: snapshot.data ?? false,
                  child: Positioned(
                    bottom: 70.0,
                    right: 0.0,
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xff7FB77E),
                      onPressed: () {
                        Navigator.pushNamed(context, '/event');
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //
        centerTitle: true,
        // Center the title of the AppBar
        title: const Text('Actualités',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),

      ),
      body: Column(
        children: [
          const AutocompleteBasicExample(),
          Expanded(
            flex: 8,
            child: BlocProvider(
              create: (_) {
                //BlocProvider.of<ActualiteBloc>(context).close();
                EvenementBloc evenementBloc = getIt<EvenementBloc>();
                if (!evenementBloc.isClosed) {
                  evenementBloc.add(EvenementGetAllEvent(
                      ListEvenements.page, ListEvenements.pageSize));
                } else {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return evenementBloc;
              }, child: BlocBuilder<EvenementBloc, EvenementState>(
              builder: (context, state) {
                if (state is ListEvenementsSuccessMessageState) {
                  return ListEvenementsWidget(evenements: ListEvenements.evenementListTest,);
                } else if (state is FilterListEvenementSuccessMessageState) {
                  ListEvenements.evenementsearchList.clear();
                  if (state.listEvenements.isNotEmpty) {
                    ListEvenements.evenementsearchList.addAll(
                        state.listEvenements);
                  }
                  // AutocompleteBasicExample.options.clear() ;

                  return ListEvenementsWidget(evenements: ListEvenements.evenementListTest);
                }
                /* else if (state is EvenementState) {
                    return  Center(
                      child:  Text('${state.errorMessage}'),
                    );
                  } */ else if (state is EvenementsEmptyState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/venteAchat/empty.svg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }

                else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            ),
          ),
          const Expanded(
            child:
            ButtonNavigationBar(), flex: 0,),
        ],
      ),
    );
  }
}
