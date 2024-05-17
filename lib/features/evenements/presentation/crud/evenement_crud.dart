import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/crud/update_buttom_sheet.dart';

import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../data/implementation/event_repository_impl.dart';
import '../../domain/usecases/get_evenements_by_username_usecase.dart';
import '../../domain/usecases/insert_evenement_usecase.dart';
import '../event/bloc/evenement_bloc.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late EvenementBloc _evenementBloc;
  List<Evenement> eventsItems = [];
  int indexDeleted = 0 ;
  @override
  void initState() {
    super.initState();
    _evenementBloc = getIt.get<EvenementBloc>();
    getIt<Functions>().getUsername().then((username) {
      _evenementBloc.add(EvenementCrudGetAllEvent(username));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFEEEEEE),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(color: Color(0xff7FB77E)),
                  flex: 2,
                ),
                Expanded(
                  flex: 5,
                  child: BlocProvider(
                    create: (_) => _evenementBloc,
                    child: BlocConsumer<EvenementBloc, EvenementState>(
                      listener: (context, state) {
                        if (state is EvenementCrudSuccessMesgsaeState) {
                          setState(() {
                            eventsItems.addAll(state.liestEveneets);
                          });
                        }else if(state is EvenementSuccessDeleteState){
                          setState(() {
                            eventsItems.removeAt(indexDeleted);
                            print('b9a hedhe = $eventsItems') ;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Supprimé avec succès'), // Display the success message
                                duration: Duration(seconds: 2), // Set the duration for the Snackbar
                              ),
                            );

                          });
                        }else if (state is EvenementSuccessUpdateState){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Modifieé avec succé'), // Display the success message
                              duration: Duration(seconds: 2), // Set the duration for the Snackbar
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: eventsItems.length,
                          itemBuilder: (context, index) {
                            Evenement event = eventsItems[index];
                            return ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  child: Text('E${event.id}'),
                                ),
                              ),
                              title: Text(event.titre!),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showEventDetailsBottomSheet(event,context) ;
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      bool shouldUpdate = await showValidationDialog(context, Icons.lock_outline, 'Voulez-vous vous déconnecter?',
                                        const Color(0xFFF28F8F),
                                        const Color(0xFF414141),
                                        const Color(0xFF1F7774),
                                        const Color(0xFFF28F8F),);
                                      if (shouldUpdate) {
                                        print('will delete with id = ${eventsItems[index].id!}') ;
                                        indexDeleted = index ;

                                        getIt<Functions>().getUsername().then((username) {
                                          _evenementBloc.add(EvenementCrudDeleteEvent(eventsItems[index].id!));
                                        });
                                      }

                                      // Show delete confirmation dialog
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(child: const ButtonNavigationBar(), flex: 0),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    title: Text(
                      'Evenements',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    subtitle: Text(
                      'Gérer vos événements',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 70,
                      height: 70,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person_outline, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}