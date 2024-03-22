import 'package:flutter/material.dart';

void showConnectionFailedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Échec de la connexion'),
        content: const Text(
            'Veuillez vérifier votre connexion Internet et réessayer.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
