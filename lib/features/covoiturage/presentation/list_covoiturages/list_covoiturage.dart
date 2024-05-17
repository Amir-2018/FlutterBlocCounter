import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../data/implementation/covoiturage_repo_impl.dart';
import '../../domain/model/covoiturage_model.dart';
import '../../domain/usecases/get_list_covoiturages_by_title_usecase.dart';
import '../../domain/usecases/get_list_covoiturages_usecase.dart';
import '../../domain/usecases/insert_covoiturage_usecase.dart';
import '../actaulitie/bloc/covoiturage_bloc.dart';
import '../covoiturage/covoiturages_search_field.dart';
import '../covoiturage/list_covoiturages_items_widget.dart';

class ListCovoiturages extends StatefulWidget {
  static List<CovoiturageModel> covoituragesList = [] ;
  static int lengthCovoituragesList = covoituragesList.length ;
  static List<CovoiturageModel>  searchList = [] ;
  static  int page = 0 ;
  static  int pageSize = 10 ;
  static  int pageSearch = 0 ;

  const ListCovoiturages({Key? key}) : super(key: key);

  @override
  _ListAnnocesState createState() => _ListAnnocesState();
}

class _ListAnnocesState extends State<ListCovoiturages> {
  @override
  void initState() {
    if (!getIt.isRegistered<CovoiturageBloc>()) {
      getIt.registerLazySingleton<CovoiturageBloc>(
            () =>
            CovoiturageBloc(InsertCovoiturageUsecase(
                covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecase(covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecaseByTitle(covoiturageRepository: CovoiturageRepositoryImpl())),
      );
    }
    ListCovoiturages.covoituragesList.clear()  ;
    ListCovoiturages.page = 0 ;
    //ActualiteBloc actualiteBloc =  getIt<ActualiteBloc>();
    //actualiteBloc.add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 70.0,
            right: 0.0,
            child: FloatingActionButton(
                backgroundColor : const Color(0xff7FB77E),

              onPressed: () {
                Navigator.pushNamed(context, '/covoiturage');
              },
              child: const Icon(Icons.add,color: Colors.white,size: 30,),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,//
        centerTitle: true, // Center the title of the AppBar
        title: const Text('Covoiturages',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white,size: 24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context) ;
          },
        ),
      ),
      body: Column(
        children: [
          const CovoiturageSearchField(),
          Expanded(
            flex: 8,
            child: BlocProvider(
              create: (_) {
                //BlocProvider.of<ActualiteBloc>(context).close();
                CovoiturageBloc covoiturageBloc = getIt<CovoiturageBloc>();
                if (!covoiturageBloc.isClosed) {
                  covoiturageBloc.add(CovoiturageGetAllEvent(ListCovoiturages.page,ListCovoiturages.pageSize));
                } else {
                   const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return covoiturageBloc;
              },      child: BlocBuilder<CovoiturageBloc, CovoiturageState>(
                builder: (context, state) {
                  if (state is ListCovoituragesSuccessMessageState) {

                    return ListCovoituragesItemsget(covoiturages:  ListCovoiturages.covoituragesList, titre: 'Covoiturages');
                  }else if(state is FilterListCovoituragesSuccessMessageState){
                    debugPrint(state.listacovoiturages.toString()) ;

                    ListCovoiturages.searchList.clear() ;
                    if(state.listacovoiturages.isNotEmpty){
                      ListCovoiturages.searchList.addAll(state.listacovoiturages) ;

                    }
                    // AutocompleteBasicExample.options.clear() ;

                    return ListCovoituragesItemsget(covoiturages:  ListCovoiturages.searchList, titre: 'Covoiturages');
                  }
                  else if (state is CovoiturageErrorState) {
                    return  Center(
                      child:  Text('${state.errorMessage}'),
                    );
                  } else if (state is CovoiturageEmptyState) {
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
    );
  }
}