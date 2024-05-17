import 'package:flutter/material.dart';

import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../domain/model/event.dart';
import '../event/bloc/evenement_bloc.dart';

void showEventDetailsBottomSheet(Evenement event,BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              //mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Type'),
                  controller: TextEditingController(text: event.type),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Titre'),
                  controller: TextEditingController(text: event.titre),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  controller: TextEditingController(text: event.description),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Position'),
                  controller: TextEditingController(text: event.position.toString()),
                  onChanged: (value) {
                    // Parse the value to update the position
                    // event.position = // Update the position
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Date de début'),
                  controller: TextEditingController(text: event.date_debut.toString()),
                  onChanged: (value) {
                    // Parse the value to update the start date
                    // event.date_debut = // Update the start date
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Date de fin'),
                  controller: TextEditingController(text: event.date_fin.toString()),
                  onChanged: (value) {
                    // Parse the value to update the end date
                    // event.date_fin = // Update the end date
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Limite'),
                  controller: TextEditingController(text: event.limite.toString()),
                  onChanged: (value) {
                    // Parse the value to update the limit
                    // event.limite = // Update the limit
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Photo'),
                  controller: TextEditingController(text: event.photo),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Catégorie'),
                  controller: TextEditingController(text: event.category),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Localisation'),
                  controller: TextEditingController(text: event.localisation),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Organisateur'),
                  controller: TextEditingController(text: event.organisateur),
                  onChanged: (value) {
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Lien d\'inscription'),
                  controller: TextEditingController(text: event.lienInscription),
                  onChanged: (value) {
                  },
                ),
                ElevatedButton(
                  onPressed: () {

                      getIt.get<EvenementBloc>().add(EvenementUpdateEvent(event));

                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}