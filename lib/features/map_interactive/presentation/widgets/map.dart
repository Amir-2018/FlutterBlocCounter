import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'map_elements/map_home_page.dart';
import 'map_elements/markers.dart';

/*class MapWidget extends StatefulWidget {
  final Future<Position> Function() determinePosition;
  const MapWidget({required this.determinePosition});
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = MapController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:OpenStreetMapSearchAndPick(onPicked: (PickedData pickedData) {  },));
  }
}*/

/*_map(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Position position = await widget.determinePosition();
            mapController.move(LatLng(position.latitude, position.longitude), 14.0);
            // Add a marker to the map at the new location
            Marker marker = Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(position.latitude, position.longitude),
              builder: (ctx) => Container(
                child: const Icon(
                  Icons.location_on,
                  size: 40.0,
                  color: Colors.red,
                ),
              ),
            );
            setState(() {
              markers.add(marker);
            });
          } catch (e) {
            debugPrint('Error getting location: $e');
          }
        },
        child: Icon(Icons.location_on),
        backgroundColor: Colors.blue,
        elevation: 5.0,
      ),
    );
  }

  Widget _map(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: const LatLng(36.900023, 10.192547),
        zoom: 15.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [
                LatLng(36.898937, 10.188298),
                LatLng(36.900023, 10.192547),
              ],
              color: Colors.blue,
              //borderStrokeWidth: 5.0
            ),
          ],
        ),
        MarkerLayer(
          markers: markers,
        ),
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search for places',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search functionality
              },
            ),
          ),
        ),
      ],
    );*/