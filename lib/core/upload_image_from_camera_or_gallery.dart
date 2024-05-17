import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../features/annonces/presentation/actaulitie/actualitie_widget.dart';

void uploadImageFromCameraORGallery(BuildContext context, String image64, Future<String> Function(ImageSource) getImage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff414141),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close,color: Colors.white,size: 15,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                getImage(ImageSource.camera).then((base64String) {
                  ActualitieWidget.image64 = base64String;
                }).catchError((error) {
                  print('Error: $error');
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                getImage(ImageSource.gallery).then((base64String) {
                  ActualitieWidget.image64 = base64String;
                }).catchError((error) {
                  print('Error: $error');
                });
              },
            ),
          ],
        ),

      );
    },
  );
}
