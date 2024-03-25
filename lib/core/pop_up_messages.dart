import 'package:flutter/material.dart';

void showValidationPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xFF1F7774), width: 2.0),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning,
                color: Colors.orange,
                size: 50.0,
              ),
              const SizedBox(height: 15.0),
              const Text(
                'Confirmation requise',
                style: TextStyle(
                  color: Color(0xFF1F7774),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Voulez-vous sauvegarder les modifications?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1F7774),
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action when "Oui" button is pressed
                      Navigator.of(context).pop();
                      // Perform save operation here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7774),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Oui',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action when "Non" button is pressed
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400], // Couleur grise pour l'annulation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Non',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showValidationCredentials(BuildContext context, String title,
    String content, IconData icon, Color colorValue, String link) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: const Color(0xFF1F7774), width: 2.0),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: colorValue,
                size: 50.0,
              ),
              const SizedBox(height: 15.0),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1F7774),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF1F7774),
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F7774),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, 'No-way');
                  },
                  child: Container(
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                        child:  Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
