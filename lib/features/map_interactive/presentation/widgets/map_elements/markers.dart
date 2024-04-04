import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
List<Marker> markers = [
  Marker(
    width: 80.0,
    height: 80.0,
    point: const LatLng(36.902166, 10.192272),
    builder: (ctx) => GestureDetector(
      onTap: () {
        showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Marker Information'),
              content: const Text('This is the information for the marker'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        child: Icon(
          Icons.location_on,
          size: 40.0,
          color: Colors.red,
        ),


      ),
    ),
  ),
];