import 'package:flutter/material.dart';
import 'package:pfechotranasmartvillage/features/venteAchat/presentation/vente/vente_widget.dart';

Future<void> PopupVenteOuAchat(BuildContext context, String option1, String option2) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text(titre,textAlign: TextAlign.center,),
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
                  VenteWidget.typeAnnonce = "vente" ;
                  Navigator.pop(context) ;
                  Navigator.pushNamed(context, '/addVente');

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
                  VenteWidget.typeAnnonce = "achat" ;
                  Navigator.pop(context) ;
                  Navigator.pushNamed(context, '/addVente');

                },
              ),
            ),
            const SizedBox(height: 10,),

            /* Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fermer'),
                ),
              ],
            ),*/
          ],
        ),
      );
    },
  );
}