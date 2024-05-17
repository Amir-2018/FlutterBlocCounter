import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_state.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/search_bar.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/search_position_line.dart';
import 'bloc_position/position_event.dart';
import 'custom_test_field.dart';
import 'bloc_position/map_home_page/map_home_page.dart';
import 'options_list_view.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';

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

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  late List<OSMdata> _options1 = <OSMdata>[];
  late List<OSMdata> _options2 = <OSMdata>[];
  FocusNode? _activeFocusNode;
  String currentPosition = ''; // Local variable to store the position value


  Timer? _debounce;
  late http.Client client;
  late Future<Position?> latlongFuture;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    client = http.Client();
    latlongFuture = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _focusNode1.addListener(() {
      setState(() {
        _activeFocusNode = _focusNode1;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _activeFocusNode = _focusNode2;
      });
    });
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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 26),

            Expanded(
                flex: 2,
                child: Column(children: [
              const Text(
                'Choisisser votre chemin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM sans',
                  color: Color(0xFF1E1E1E),
                ),
              ),

              // Position info
             /* FutureBuilder<Position?>(
                future: latlongFuture,
                builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    double latitude = snapshot.data!.latitude;
                    double longitude = snapshot.data!.longitude;
                    return Column(
                      children: [
                        Text(
                          'Lat: $latitude, Lon: $longitude',
                          style: const TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),*/
              const SizedBox(height: 26),
              // SearchBarWidget

                  Expanded(
                    child: ListView(
                      children: [
                        BlocListener<PositionBloc, PositionState>(
                          listener: (context, state) {
                            if (state is PositionSuccessState) {
                              final storage = FlutterSecureStorage();

                              //Point? pos1, pos2;

                              // Perform asynchronous work first
                              if (_activeFocusNode == _focusNode1) {
                                _searchController.text = currentPosition = state.destinationPosition.nameDestination;
                                PointLocation pos1 = PointLocation(
                                  //name: state.destinationPosition.nameDestination,
                                  lat: state.destinationPosition.pointPosition.lat, // Utilisation de la latitude de la position
                                  lng: state.destinationPosition.pointPosition.lng,
                                );

                                // Save pos1 in FlutterSecureStorage
                                storage.write(key: 'pos1', value: jsonEncode(pos1.toJson())).then((_) {
                                  //debugPrint("Amir is here ${state.destinationPosition.pointPosition.latitude}, ${state.destinationPosition.pointPosition.longitude}");

                                  // Update state synchronously
                                  setState(() {});
                                });
                              } else if (_activeFocusNode == _focusNode2) {
                                // Read pos1 from FlutterSecureStorage first
                                storage.read(key: 'pos1').then((value) {
                                  PointLocation pos1 = PointLocation.fromJson(jsonDecode(value!));

                                  _searchController2.text = currentPosition = state.destinationPosition.nameDestination;
                                  PointLocation pos2 = PointLocation(
                                    //name: state.destinationPosition.nameDestination,
                                    lat: state.destinationPosition.pointPosition.lat,
                                    lng : state.destinationPosition.pointPosition.lng
                                    //position: state.destinationPosition.pointPosition,
                                  );

                                  // debugPrint("Amir is here ${state.destinationPosition.pointPosition.latitude}, ${state.destinationPosition.pointPosition.longitude}");

                                    BlocProvider.of<PositionBloc>(context).add(
                                      SendLocationsEvent(location1: pos1, location2: pos2),
                                    );

                                    // Navigate to the previous screen
                                    Navigator.of(context).pop();

                                    // Update state synchronously
                                    setState(() {});

                                });
                              }
                            }
                          },
                          child: SearchBarLine(
                            hintText: 'Choisissez un point de départ',
                            baseUri: widget.baseUri,
                            mapController: _mapController,
                            searchController: _searchController,
                            focusNode: _focusNode1,
                            options: _options1,
                            debounce: Timer(const Duration(milliseconds: 100), () {}),
                            marginLeft: 0,
                            marginRight: 0,
                            marginTop: 0,
                            updateOptions: (List<OSMdata> updatedOptions) {
                              setState(() {
                                _options1 = updatedOptions;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16,),
                        SearchBarLine(
                          hintText: 'Choisissez une destination',
                          baseUri: widget.baseUri,
                          mapController: _mapController,
                          searchController: _searchController2,
                          focusNode: _focusNode2,
                          options: _options2,
                          debounce: Timer(const Duration(milliseconds: 100), () {}),
                          marginLeft: 0,
                          marginRight: 0,
                          marginTop: 0,
                          updateOptions: (List<OSMdata> updatedOptions) {
                            setState(() {
                              _options2 = updatedOptions;//

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                 // const SizedBox(height: 20,) ,


            ],)),


            if (_activeFocusNode == _focusNode1 && _searchController.text.isNotEmpty)
              Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    Container(
                      child: _options1.isEmpty
                          ? const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator.adaptive(
                              strokeWidth: 4.0,//
                              backgroundColor: Color(0xff7FB77E),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5d805e)),
                            ),
                            SizedBox(height: 20,),
                            Text('En cours de chargement...',
                            style: TextStyle(
                              color: Color(0xff414141),
                              fontSize: 18
                            ),
                            ),
                          ],
                        )
                      )
                          : OptionsListView(
                        options: _options1,
                        mapController: _mapController,
                        focusNode: _focusNode1,
                      ),
                    ),
                  ],
                ),
              )
            else if (_activeFocusNode == _focusNode2 && _searchController2.text.isNotEmpty)
              Expanded(
                flex: 4,
                child: Container(
                  child: _options2.isEmpty
                      ? const Center(
                    child: Column(
                          children: [
                            CircularProgressIndicator.adaptive(
                              strokeWidth: 4.0,
                              backgroundColor: Color(0xff7FB77E),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5d805e)),
                            ),
                          SizedBox(height: 20,),
                          Text('En cours de chargement...',//
                          style: TextStyle(
                            color: Color(0xff414141),
                            fontSize: 18
                          ),
                          ),
                          ],
    ) // Circular progress indicator
                  )
                      : OptionsListView(
                    options: _options2,
                    mapController: _mapController,
                    focusNode: _focusNode2,
                  ),
                ),
              )
            //Expanded(child: Container()),


            // Title

          ],
        ),
      ),
    );
  }
}