
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/model/establishment.dart';
import 'bloc_position/position_bloc.dart';
import 'bloc_position/position_event.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

import 'go_to_selected_position.dart';

List<PointLocation> polylines = [
  const PointLocation(lat: 36.8978188, lng: 10.1868324),
  const PointLocation(lat: 36.8988555, lng: 10.1871929),
  const PointLocation(lat: 36.8998611, lng: 10.1878452),
  const PointLocation(lat: 36.9018309, lng: 10.1890168),
  const PointLocation(lat: 36.9057404, lng: 10.1914930),
  const PointLocation(lat: 36.9039220, lng: 10.1938319),
  const PointLocation(lat: 36.9035983, lng: 10.1938663),
  const PointLocation(lat: 36.9032873, lng: 10.1939821),
  const PointLocation(lat: 36.9017520, lng: 10.1963983),
  const PointLocation(lat: 36.9001734, lng: 10.1986084),
  const PointLocation(lat: 36.8952280, lng: 10.1935616),
  const PointLocation(lat: 36.8967064, lng: 10.1916969),
  const PointLocation(lat: 36.8978046, lng: 10.1868260),
];


Polygon drawPolygon(List<LatLng> borders, double strokeWidthZone, bool isFilledState) {
  return Polygon(
    points: borders,
    color: isFilledState ? Colors.black.withOpacity(0.2) : Colors.transparent,
    borderColor: Colors.black,
    borderStrokeWidth: strokeWidthZone,
    isFilled: isFilledState,
  );
}

void showEstablishmentDialog(BuildContext context, Establishment establishment) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              establishment.nom,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Type: ${establishment.categorie}'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Tel: ${establishment.telephone}'),
            ),
            ListTile(
              leading: Icon(Icons.print),
              title: Text('Fax: ${establishment.fax}'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Contact: ${establishment.telephone}'),
            ),
            ListTile(
              leading: Icon(Icons.square_foot),
              title: Text('Surface: ${establishment.surface}'),
            ),
            // Add more information as needed
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7FB77E)),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentLocation = await getCurrentLocation();
                      final currentLocationArea = currentLocation;
                      final establishmentLocation = establishment.position;

                      final desiredLocationArea = establishmentLocation;

                      BlocProvider.of<PositionBloc>(context).add(
                        SendLocationsEvent(location1: currentLocationArea, location2: desiredLocationArea),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7FB77E)),
                    ),
                    child: Center(child: Icon(Icons.directions_outlined, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


