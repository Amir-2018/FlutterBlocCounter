
import 'package:flutter/material.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/widgets.dart';
  import 'package:flutter_map/flutter_map.dart';
  import 'package:http/http.dart' as http;
  import 'package:latlong2/latlong.dart';
  import 'package:osrm/osrm.dart';
  import 'bloc_position/position_state.dart';
  import 'package:geolocator/geolocator.dart';
  import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

  Future<PointLocation> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return PointLocation(lat: position.latitude, lng: position.longitude);
  }

  Future<Widget> getRoute(PositionState state) async {
    final osrm = Osrm();
    final currentLocation = await getCurrentLocation();

    if (state is RoadState) {
      final options = RouteRequest(
        coordinates: [
          (currentLocation.lng, currentLocation.lat),
          (state.location2.lng, state.location2.lat),
        ],
      );

      return FutureBuilder(
        future: osrm.route(options),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show an error message if fetching data fails
          } else {
            List<Map<String, double>> road = snapshot.data!.routes.first.geometry!.lineString!.coordinates.map((e) {
              return e.toCoordinateMap();
            }).toList();

            List<LatLng> latLngList = road.map((e) => LatLng(e['lat']!, e['lng']!)).toList();

           /* final markers = [
              Marker(
                width: 80.0,
                height: 80.0,
                point: state.location1.,
                builder: (context) => GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: const Offset(0.0, 3.0),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          size: 30.0,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: state.location2.position,
                builder: (context) => GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: const Offset(0.0, 3.0),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          size: 30.0,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ];*/

            final polylineLayer = PolylineLayer(
              polylines: [
                Polyline(
                  points: latLngList,
                  color: Colors.red,
                  strokeWidth: 4,
                ),
              ],
            );

            return Stack(
              children: [
                polylineLayer,
                /*MarkerLayer(
                  markers: markers,
                ),*/
              ],
            );
          }
        },
      );
    }

    return Container(); // Return a placeholder if the state is not a RoadState
  }
