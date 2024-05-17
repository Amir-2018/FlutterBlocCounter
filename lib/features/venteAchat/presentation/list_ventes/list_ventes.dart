import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/widgets/list_annonces_widget.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../core/widgets/show_option_popup.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../data/implementation/vente_achat_repository_impl.dart';
import '../../domain/model/vente.dart';
import '../../domain/usecases/get_list_ventes_by_title_usecase.dart';
import '../../domain/usecases/get_list_ventes_usecase.dart';
import '../../domain/usecases/insert_vente_usecase.dart';
import '../pop_up_vente_ou_achat.dart';
import '../vente/bloc/vente_bloc.dart';
import '../vente/list_ventes_items_widget.dart';
import '../vente/list_ventes_widget.dart';
import '../vente/vente_search_field_all.dart';

class ListVentes extends StatefulWidget {
  static List<Vente> ventListes = [] ;
  static int lengthAnnoncesList = ventListes.length ;
  static List<Vente>  searchList = [] ;
  static  int page = 0 ;
  static  int pageSearch = 0 ;
  static  int pageSize = 10 ;



  const ListVentes({Key? key}) : super(key: key);

  @override
  _ListAnnocesState createState() => _ListAnnocesState();
}

class _ListAnnocesState extends State<ListVentes> {
  @override
  void initState() {
    if (!getIt.isRegistered<VenteBloc>()) {
      getIt.registerLazySingleton<VenteBloc>(
            () =>
            VenteBloc(InsertVenteUsecase(
                venteRepository: VenteAchatRepositoryImpl()),GetListVentesUsecase(venteRepository: VenteAchatRepositoryImpl()),GetListVentesByTitleUsecase(venteRepository: VenteAchatRepositoryImpl())),
      );
    }
    ListVentes.page  = 0 ;
    ListVentes.ventListes.clear()  ;
    //ActualiteBloc actualiteBloc =  getIt<ActualiteBloc>();
    //actualiteBloc.add(ActualiteGetAllEvent(ListAnnoces.page,ListAnnoces.pageSize));
    super.initState();
  }


  @override
  Widget build(BuildCont) {


    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(

            bottom: 70.0,
            right: 0.0,
            child: FloatingActionButton(
                heroTag : 'Add method ',
                backgroundColor : const Color(0xff7FB77E),

              onPressed: () {
                PopupVenteOuAchat(context,'Vente','Achat') ;
              },
              child: const Icon(Icons.add,color: Colors.white,size: 30,),
            ),
          ),

          Positioned(

            bottom: 140.0,
            right: 0.0,
            child: FloatingActionButton(
              heroTag : 'The filtered method ',

              backgroundColor :  Colors.white,

              onPressed: () {
                showOptionsPopup(context,'Filtrer','Ventes','Achats','Tous') ;
              },
              child: const Icon(Icons.filter_list_alt,color:  Color(0xff7FB77E),size: 30,),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,//
        centerTitle: true, // Center the title of the AppBar
        title: const Text('Ventes & Achats',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white,size: 24),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context) ;
          },
        ),
      ),
      body: Column(
        children: [
          const Expanded(child:  VenteSearchField(),flex: 0,),
          Expanded(
            flex: 8,
            child: BlocProvider(
              create: (_) {
                //BlocProvider.of<VenteBloc>(context).close();
                VenteBloc venteBloc = getIt<VenteBloc>();
                if (!venteBloc.isClosed) {
                  venteBloc.add(VenteGetAllEvent(ListVentes.page,ListVentes.pageSize));
                  // ListVentes.page += 1  ;

                } else {
                   const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return venteBloc;
              },      child: BlocBuilder<VenteBloc, VenteState>(
                builder: (context, state) {

                  if (state is ListVenteSuccessMessageState) {

                    //ListVentes.ventListes.addAll(state.ventes) ;
                    ListVentes.page += 1  ;
                  //   debugPrint('${ListVentes.ventListes}') ;
                      return ListVentesItemsWidget(listVentes:  ListVentes.ventListes, titre: 'Ventes & Achats');

                  }else if(state is FilterListVenteSuccessMessageState){
                    ListVentes.searchList.clear() ;
                    ListVentes.searchList.addAll(state.ventes) ;

                    // AutocompleteBasicExample.options.clear() ;

                    return ListVentesItemsWidget(listVentes:  ListVentes.searchList, titre: 'Ventes & Achats');
                  }else if(state is FilterListVenteSuccessMessageVentesouAchatState){
                    ListVentes.searchList.clear() ;
                    ListVentes.searchList.addAll(state.ventes) ;

                    // AutocompleteBasicExample.options.clear() ;

                    return ListVentesItemsWidget(listVentes:  ListVentes.searchList, titre: 'Ventes & Achats');
                  }
                  else if (state is VenteErrorState) {
                    return  Center(
                      child:  Text('${state.errorMessage}'),
                    );
                  }else if (state is VenteEmptyState) {
                    return  Center(
                      child:  SvgPicture.asset(
                        'assets/venteAchat/empty.svg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
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