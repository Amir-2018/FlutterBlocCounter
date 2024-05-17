import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/bloc/vente_bloc.dart';

import '../../features/annonces/presentation/actaulitie/bloc/actualite_bloc.dart';
import '../../features/venteAchat/presentation/list_ventes/list_ventes.dart';
import '../dependencies_injection.dart';

Future<void> showOptionsPopup(BuildContext context, String titre, String option1, String option2, String option3) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titre,textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),

                  border: Border.all(color: const Color(0xff1F7774))
              ),
              child: ListTile(
                title: Center(child: Text(option1)),
                onTap: () {
                  ListVentes.page = 0 ;

                  BlocProvider.of<VenteBloc>(context).add(
                    GetAchaOuAchattEventOnly(
                        ListVentes.page,
                      ListVentes.pageSize,
                      'vente'
                    ),
                  );
                 Navigator.pop(context);

                  // Handle option 1 selection
                  // Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),

                  border: Border.all(color: const Color(0xff1F7774))
              ),
              child: ListTile(
                title: Center(child: Text(option2)),
                onTap: () {
                  ListVentes.page = 0 ;

                  BlocProvider.of<VenteBloc>(context).add(
                    GetAchaOuAchattEventOnly(
                        ListVentes.page,
                        ListVentes.pageSize,
                        'achat'
                    ),
                  );
                  Navigator.pop(context);

                },
              ),
            ),
            const SizedBox(height: 10,),

            Container(

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),

                  border: Border.all(color: const Color(0xff1F7774))
              ),
              child: ListTile(
                title: Center(child: Text(option3)),
                onTap: () {
                    VenteBloc venteBloc = getIt<VenteBloc>() ;
                    if (!venteBloc.isClosed) {
                      // ListAnnoces.actulitesList.clear() ;
                      // ListAnnoces.searchList.clear() ;
                      ListVentes.page = 0;
                      venteBloc.add(VenteGetAllEvent(ListVentes.page,ListVentes.pageSize));
                      ListVentes.page += 1  ;
                    } else {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    Navigator.pop(context);

                },
              ),
            ),

          ],
        ),
      );
    },
  );
}