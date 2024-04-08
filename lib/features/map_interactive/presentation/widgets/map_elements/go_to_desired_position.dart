import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/search_bar.dart';
import 'custom_test_field.dart';
import 'map_home_page.dart';

class GoToDesiredPosition extends StatefulWidget {
  const GoToDesiredPosition({Key? key, required this.baseUri}) : super(key: key);

  final String baseUri;

  @override
  _GoToDesiredPositionState createState() => _GoToDesiredPositionState();
}

class _GoToDesiredPositionState extends State<GoToDesiredPosition> {
  late MapController _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  late List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;
  late http.Client client;
  late Future<Position?> latlongFuture;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    client = http.Client();
    latlongFuture = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    String url = '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    _searchController.text = decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    _searchController2.text = decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Search bar
            /*Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                child: SearchBarWidget(
                  hintText: 'Search...',
                  baseUri: widget.baseUri,
                  mapController: _mapController,
                  searchController: _searchController,
                  focusNode: _focusNode,
                  options: _options,
                  debounce: Timer(Duration(milliseconds: 2000), () {}),
                  marginLeft: 0,
                  marginRight: 0,
                  marginTop: 0,
                ),
              ),
            ),*/

            // Title
            const Positioned(
              top: 50,
              left: 0,
              child:  Text(
                'Choisir votre position',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM sans',
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            const Positioned(
              top: 95,
              left: 0,
              child:  Text(
                'Votre position',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM sans',
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            // Position info
            Positioned(
              top: 145,
              left: 0,
              child: Column(
                children: [

                  FutureBuilder<Position?>(
                    future: latlongFuture,
                    builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        double latitude = snapshot.data!.latitude;
                        double longitude = snapshot.data!.longitude;
                        return Text(
                          'Lat: $latitude, Lon: $longitude',
                          style: const TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 12,
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),

            // Search field
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Container(
                //color: Color(0xFFF5F5F5),
                height: 100,
                child: SearchBarWidget(
                  hintText: 'Search...',
                  baseUri: widget.baseUri,
                  mapController: _mapController,
                  searchController: _searchController,
                  focusNode: _focusNode,
                  options: _options,
                  debounce: Timer(Duration(milliseconds: 2000), () {}),
                  marginLeft: 0,
                  marginRight: 0,
                  marginTop: 0,
                ),
              ),
            ),

            Positioned(
              top: 230,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                child: SearchBarWidget(
                  hintText: 'Search...',
                  baseUri: widget.baseUri,
                  mapController: _mapController,
                  searchController: _searchController,
                  focusNode: _focusNode,
                  options: _options,
                  debounce: Timer(Duration(milliseconds: 2000), () {}),
                  marginLeft: 0,
                  marginRight: 0,
                  marginTop: 0,
                ),
              ),
            ),

            // Itinerary button
            Positioned(
              //bottom: 0,
              top: 320,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF7FB77E),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Itinéraire',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                          ),
                        ),
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
  }
}