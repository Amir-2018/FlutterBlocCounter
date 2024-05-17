import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/map_interactive/domain/model/point_location.dart';

class Functions {

  Uint8List base64Decode(String source) => base64.decode(source);

  Future<String> loadAssetAsBase64(String assetPath) async {

    File imagefile = File(assetPath);
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return 'data:image/png;base64,${base64string}';
  }

  Uint8List decodeBase64String(String encodedString) {
    String newDecodeImage = encodedString.split('data:image/png;base64,')[1]  ;
    Uint8List decodedData = base64Decode(newDecodeImage);
    return decodedData ;

  }
  final storage = FlutterSecureStorage();

  Future<bool> verifyTokenExistence() async {
    final token = await storage.read(key: 'access_token');

    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUsername() async {
    final username = await storage.read(key: 'username');
    if (username != null) {
      return username;
    } else {
      throw Exception('Username not found in storage');
    }
  }
  PointLocation stringToPointLocation(String str) {
    List<String> parts = str.split(',');
    if (parts.length != 2) {
      throw FormatException('La chaîne doit être au format "latitude,longitude"');
    }

    double lat = double.parse(parts[0]);
    double lng = double.parse(parts[1]);

    return PointLocation(lat: lat, lng: lng);
  }

}

