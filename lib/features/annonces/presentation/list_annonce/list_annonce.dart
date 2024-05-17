import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/usecases/get_actualities_of_today_usecase.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/widgets/list_annonces_widget.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../data/implementation/actualite_repo_impl.dart';
import '../../domain/model/actualite.dart';
import '../../domain/usecases/get_list_actualities_by_title_usecase.dart';
import '../../domain/usecases/get_list_actualities_usecase.dart';
import '../../domain/usecases/insert_actualitie_usecase.dart';
import '../actaulitie/bloc/actualite_bloc.dart';

class ListAnnoces extends StatefulWidget {
  static List<Actualite> actulitesList = [] ;
  static int lengthAnnoncesList = actulitesList.length ;
  static List<Actualite>  searchList = [] ;
  static  int page = 0 ;
  static  int pageSize = 10 ;


  const ListAnnoces({Key? key}) : super(key: key);

  @override
  _ListAnnocesState createState() => _ListAnnocesState();
}

class _ListAnnocesState extends State<ListAnnoces> {
  String selectedTitle = '';


  //ActualiteBloc actualiteBloc = getIt<ActualiteBloc>();

  @override
  void initState() {

    if (!getIt.isRegistered<ActualiteBloc>()) {
      getIt.registerLazySingleton<ActualiteBloc>(
            () =>
            ActualiteBloc(InsertActualityUsecase(
                actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecase(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecaseByTitle(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesOfTodayeUsecase(actualiteRepository: ActualiteRepositoryImpl())),
      );
    }
    ActualiteBloc actualiteBloc = getIt<ActualiteBloc>();

    ListAnnoces.actulitesList.clear()  ;
    ListAnnoces.page = 0 ;
    //ActualiteBloc actualiteBloc =  getIt<ActualiteBloc>();
    //actualiteBloc.add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSelectionFromArguments();
    });

  }

  void _getSelectionFromArguments() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['selection'] != null) {
      setState(() {
        selectedTitle = args['selection']!;
      });
      ListAnnoces.page = 0;
      getIt<ActualiteBloc>().add(GetActualitiesByTitle(ListAnnoces.page, ListAnnoces.pageSize, selectedTitle));
    } else {
      getIt<ActualiteBloc>().add(ActualiteGetAllEvent(ListAnnoces.page, ListAnnoces.pageSize));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('I HAVE THE SELECTED $selectedTitle');
    return Scaffold(

      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 70.0,
            right: 0.0,
            child: FloatingActionButton(
                backgroundColor : const Color(0xff7FB77E),

              onPressed: () {
                Navigator.pushNamed(context, '/actualite');
              },
              child: const Icon(Icons.add,color: Colors.white,size: 30,),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,//
        centerTitle: true, // Center the title of the AppBar
        title: const Text('Actualités',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: const Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white,size: 24),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            BlocProvider.of<ActualiteBloc>(context).add(GetActualitesOfTodays());
            Navigator.pop(context);
          },
        ),

      ),
      body: Container(
        color: const Color(0xffFFFFFF),
        child: Column(
          children: [
            const AutocompleteBasicExample(),
            Expanded(
              flex: 8,
              child: BlocProvider(
                create: (_) {

                  //BlocProvider.of<ActualiteBloc>(context).close();
                /*  if (!getIt<ActualiteBloc>().isClosed) {
                    getIt<ActualiteBloc>().add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
                  } else {
                     const Center(
                      child: CircularProgressIndicator(),
                    );
                  }*/
                  return getIt<ActualiteBloc>();
                },      child: BlocBuilder<ActualiteBloc, ActualiteState>(
                  builder: (context, state) {
                    if(state is FilterListActualiteSuccessMessageForServicesState){
                      print('Yesss its the state') ;
                      ListAnnoces.searchList.clear() ;
                      if(state.listactualities.isNotEmpty){
                        ListAnnoces.searchList.addAll(state.listactualities) ;

                      }
                      // AutocompleteBasicExample.options.clear() ;

                      return ListAnnocesWidget(annonces:  ListAnnoces.searchList, titre: 'Actualités');
                    }else
                    if (state is ListActualiteSuccessMessageState) {

                      return ListAnnocesWidget(annonces:  ListAnnoces.actulitesList, titre: 'Actualités');
                    }else if(state is FilterListActualiteSuccessMessageState){
                      //debugPrint(state.listactualities.toString()) ;

                      ListAnnoces.searchList.clear() ;
                      if(state.listactualities.isNotEmpty){
                        ListAnnoces.searchList.addAll(state.listactualities) ;

                      }
                      // AutocompleteBasicExample.options.clear() ;

                      return ListAnnocesWidget(annonces:  ListAnnoces.searchList, titre: 'Actualités');
                    }
                    else if (state is ActualiteErrorState) {
                      return  Center(
                        child:  Text('${state.errorMessage}'),
                      );
                    } else if (state is ActualiteEmptyState) {
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child:  SvgPicture.asset(
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
               ButtonNavigationBar(),flex: 0,),
          ],
        ),
      ),
    );
  }
}