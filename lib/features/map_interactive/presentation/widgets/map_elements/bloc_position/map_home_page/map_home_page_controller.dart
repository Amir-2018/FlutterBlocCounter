
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/model/establishment.dart';
import '../../../../../domain/model/lot.dart';
import '../position_bloc.dart';
import '../position_event.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

import '../../go_to_selected_position.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map_home_page.dart';





Polygon drawPolygon(List<LatLng> borders, double strokeWidthZone, bool isFilledState) {
  return Polygon(
    points: borders,
    color: isFilledState ? Colors.black.withOpacity(0.2) : Colors.transparent,
    borderColor: Colors.black,
    borderStrokeWidth: strokeWidthZone,
    isFilled: isFilledState,
  );
}
Polygon drawPolygonForLots(List<LatLng> borders, double strokeWidthZone, bool isFilledState, bool etat,String namedLabel,int numTestingVisibility) {
  return Polygon(
    points: borders,
    color: etat ?Colors.green.withOpacity(0.3)  : Colors.red.withOpacity(0.3),
    borderColor: Colors.black,
    borderStrokeWidth: strokeWidthZone,
    isFilled: isFilledState,
    label: namedLabel,
    labelStyle: numTestingVisibility % 2 != 0
        ? TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 14, color: Colors.transparent, fontWeight: FontWeight.bold),
  );
}


  // Show the dropdown menu



void smoothZoomIn(MapController mapController) {
  double targetZoom = mapController.zoom + 1;
  double currentZoom = mapController.zoom;
  double zoomStep = 0.1; // Adjust the step for smoother or faster zooming

  Timer.periodic(Duration(milliseconds: 16), (timer) {
    if (currentZoom < targetZoom) {
      currentZoom += zoomStep;
      mapController.move(mapController.center, currentZoom);
    } else {
      timer.cancel();
    }
  });
}

void smoothZoomOut(MapController mapController) {
  double targetZoom = mapController.zoom - 1;
  double currentZoom = mapController.zoom;
  double zoomStep = 0.1; // Adjust the step for smoother or faster zooming

  Timer.periodic(Duration(milliseconds: 16), (timer) {
    if (currentZoom > targetZoom) {
      currentZoom -= zoomStep;
      mapController.move(mapController.center, currentZoom);
    } else {
      timer.cancel();
    }
  });
}

void foncusOntarget(MapController mapController, LatLng targetPosition) {
  double targetZoom = 17;
  double currentZoom = mapController.zoom;
  double zoomStep = 0.1; // Adjust the step for smoother or faster zooming

  Timer.periodic(Duration(milliseconds: 16), (timer) {
    if (currentZoom < targetZoom) {
      currentZoom += zoomStep;
      mapController.move(targetPosition, currentZoom);
    } else {
      timer.cancel();
    }
  });
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
            InkWell(
              onTap: () {
                // Use the url_launcher package to open the link
                launchUrl(Uri.parse(establishment.lien));
                Navigator.of(context).pop();
              },
              child: ListTile(
                leading: Icon(Icons.link),
                title: Text('${establishment.nom}',style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),),
              ),
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
                    onPressed: ()  async {
                      final currentLocation = await getCurrentLocation();
                      final currentLocationArea = currentLocation;
                      final establishmentLocation = establishment.position;

                      final desiredLocationArea = establishmentLocation;

                      Navigator.of(context).pop();
                      BlocProvider.of<PositionBloc>(context).add(
                        // current Location
                        SendLocationsEvent(location1: PointLocation(lat : 36.897295, lng : 10.194307), location2: desiredLocationArea),
                          );
                        foncusOntarget( OpenStreetMapSearchAndPickState.mapController,const LatLng(36.897295,10.194307, )) ;


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


LatLng latLngFromPoint(PointLocation point) {
  return LatLng(point.lat, point.lng);
}

List<PointLocation> latLngsToPoints(List<LatLng> latLngs) {
  return latLngs.map((latLng) => PointLocation(lat: latLng.latitude, lng: latLng.longitude)).toList();
}

List<LatLng> pointsToLatLngs(List<PointLocation> points) {
  return points.map((point) => LatLng(point.lat, point.lng)).toList();
}
Widget buildLocationWidget(IconData locationPinIcon) {
  return Positioned.fill(
    child: IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pink icon is here
            Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: Icon(
                locationPinIcon,
                size: 50,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildLocationPin(IconData currentLocationIcon,bool currrent_location_visibility) {
  return Positioned.fill(
    child: IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Visibility(
                visible: currrent_location_visibility,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    currentLocationIcon,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}