import 'package:flutter/material.dart';

Future<bool> showValidationDialog(BuildContext context,IconData icon,String message,Color  colorIcon,Color colorText, Color colorValidation,Color colorCancelling) async {
  bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Icon(
              icon,
              color: colorIcon,
              size: 50.0,
            ),
            const SizedBox(height: 15.0),
             Text(
              message,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: colorText,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true when "oui" is clicked
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:colorValidation, // Background color for "oui"
                    // primary: Colors.white, // Text color for "oui"
                  ),
                  child: const Text(
                    'oui',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return false when "non" is clicked
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: colorCancelling, // Background color for "non"
                    //primary: Colors.white, // Text color for "non"
                  ),
                  child: Text(
                    'non',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );

  return result ?? false; // Return false if result is null
}





void showValidationCredentials(BuildContext context, String title,
    String content, IconData icon, Color colorValue,Color colorTitle,Color colorContent,Color  colorButton,String?  link ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(

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
                style:  TextStyle(
                    color: colorTitle,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                content,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color:  colorContent,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                    if (link != null) {
                      Navigator.of(context).pop();

                    Navigator.pushNamed(context, link);

                    } else {
                    Navigator.of(context).pop();
                }},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
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


void _showLocationPinButton(BuildContext context, String locationPinText,
    IconData locationPinIcon, Color locationPinIconColor,
    TextStyle locationPinTextStyle) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Positioned.fill(
        child: IgnorePointer(
          child: Center(
            child: Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF7FB77E), // Use the color #7FB77E
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      locationPinText,
                      style: locationPinTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10), // Adjust as needed for spacing
                    Icon(
                      locationPinIcon,
                      size: 30, // Adjust the size of the icon as needed
                      color: locationPinIconColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


