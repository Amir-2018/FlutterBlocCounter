import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(52.52000, 13.41000),
            zoom: 16.0,
            minZoom: 15.0,
            maxZoom: 22.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'YOUR_TILESET_URL',
              additionalOptions: {
                'attribution':
                '© Data <a href="http://openstreetmap.org/copyright/">OpenStreetMap</a> · © Map <a href="http://mapbox.com">Mapbox</a>',
              },
            ),
            TileLayer(
              urlTemplate:
              'http://{s}.data.osmbuildings.org/0.2/anonymous/tile/{z}/{x}/{y}.json',
            ),
          ],
        ),
      ),
    );
  }
}