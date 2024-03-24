import 'package:flutter/material.dart';

void showConnectionFailedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0xFF1F7774), width: 2.0),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Color(0xFF1F7774),
                size: 50.0,
              ),
              SizedBox(height: 15.0),
              Text(
                'Échec de la connexion',
                style: TextStyle(
                  color: Color(0xFF1F7774),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Veuillez vérifier votre connexion Internet et réessayer.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1F7774),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1F7774),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.0,
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
