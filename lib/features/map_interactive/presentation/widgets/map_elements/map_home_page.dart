// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/authentication/data/implementation/user_repository_impl.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/bloc/zone_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/bloc/zone_event.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/repository/map_repository.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/polylines.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/search_bar.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/wide_button.dart';

import '../../../../../core/dependencies_injection.dart';
import '../../../../../main.dart';
import '../../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../bloc/zone_state.dart';
import '../../../data/implementation/map_repository_impl.dart';
import '../button_sheet/bottom_sheet.dart';
import 'custom_search_field.dart';
import 'go_to_desired_position.dart';
import 'markers.dart';
class OpenStreetMapSearchAndPick extends StatefulWidget {
  final LatLong center;
  final void Function(PickedData pickedData) onPicked;
  final Future<LatLng> Function() onGetCurrentLocationPressed;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final IconData locationPinIcon;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color locationPinIconColor;
  final String locationPinText;
  final TextStyle locationPinTextStyle;
  final String buttonText;
  final String hintText;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle buttonTextStyle;
  final String baseUri;

  static Future<LatLng> nopFunction() {
    throw Exception("");
  }

  const OpenStreetMapSearchAndPick(

   {Key? key,
        this.center = const LatLong(0, 0),
        required this.onPicked,
        this.zoomOutIcon = Icons.zoom_out_map,
        this.zoomInIcon = Icons.zoom_in_map,
        this.currentLocationIcon = Icons.my_location,
        this.onGetCurrentLocationPressed = nopFunction,
        this.buttonColor = Colors.blue,
        this.locationPinIconColor = Colors.blue,
        this.locationPinText = 'Location',
        this.locationPinTextStyle = const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        this.hintText = 'Search Location',
        this.buttonTextStyle = const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        this.buttonTextColor = Colors.white,
        this.buttonText = 'Set Current Location',
        this.buttonHeight = 50,
        this.buttonWidth = 200,
        this.baseUri = 'https://nominatim.openstreetmap.org',
        this.locationPinIcon = Icons.location_on})
      : super(key: key);

  @override
  State<OpenStreetMapSearchAndPick> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState
    extends State<OpenStreetMapSearchAndPick> {
  List<int> _selectedCategories = [];


  MapController _mapController = MapController();

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  late List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;
  var client = http.Client();
  late Future<Position?> latlongFuture;

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    _searchController2.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  void setNameCurrentPosAtInit() async {
    double latitude = widget.center.latitude;
    double longitude = widget.center.longitude;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }

    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    _searchController2.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  @override
  void initState() {
    _mapController = MapController();

    setNameCurrentPosAtInit();

    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            '${widget.baseUri}/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.get(Uri.parse(url));
        // var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
        as Map<dynamic, dynamic>;

        _searchController.text = decodedResponse['display_name'];
        _searchController2.text = decodedResponse['display_name'];

        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var latL = [48.8945265,48.8832498,48.8583694,48.9352576];
    var lonL = [2.2608798,2.2876141,2.2797794,2.3242512];
    initDependencies() ;
    // String? _autocompleteSelection;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 1.0),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: BlocBuilder<ZoneBloc, ZoneState>(
                        builder: (context, state) {
                          if (state is ZoneSuccessState) {
                            return FlutterMap(
                              options: MapOptions(
                                center: const LatLng(36.900415, 10.192256),
                                zoom: 15.5,
                                maxZoom: 18,
                                minZoom: 2,
                              ),
                              mapController: _mapController,
                              children: [
                                TileLayer(
                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: const ['a', 'b', 'c'],
                                ),
                                PolylineLayer(
                                  polylines: [

                                    Polyline(
                                      points: polylines,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                MarkerLayer(
                                  markers:[
                                    Marker(
                                      width: 30.0,
                                      height: 30.0,
                                      point: state.zone.establishment[0].position,
                                      builder: (context) => GestureDetector(
                          onTap: () {
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
                                        state.zone.establishment[0].nom,
                                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20.0),
                                      ListTile(
                                        leading: Icon(Icons.category),
                                        title: Text('Type: ${state.zone.establishment[0].type}'),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text('Tel: ${state.zone.establishment[0].tel}'),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.print),
                                        title: Text('Fax: ${state.zone.establishment[0].fax}'),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text('Contact: ${state.zone.establishment[0].contact}'),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.square_foot),
                                        title: Text('Surface: ${state.zone.establishment[0].surface}'),
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
                                                child: const Text('OK',style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,

                                                ),),
                                              ),
                                            ),

                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7FB77E)),
                                                ),
                                                child:       Center(child: Icon(Icons.directions_outlined, color: Colors.white)), // Icône d'itinéraire

                                              ),
                                            ),


                                          ],
                                        ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 30.0,
                                              color: Colors.red,
                                            ),
                                           /* Text(
                                              state.zone.establishment[0].nom,
                                              style: TextStyle(fontSize: 12.0, color: Colors.black),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              ],
                            );
                          } else if (state is ZoneErrorState) {
                            return Center(
                              child: Text(state.errormessage),
                            );
                          } else {
                            // Handle other states if needed
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                  SearchBarWidget(
                    marginTop: 0,
                    marginLeft: 0,
                    marginRight: 0,
                    hintText: 'Search...',
                    baseUri: 'https://nominatim.openstreetmap.org',
                    mapController: _mapController,
                    searchController: _searchController,
                    focusNode: _focusNode,
                    options: _options,
                    debounce: Timer(Duration(milliseconds: 2000), () {}),
                  ),
                  Positioned.fill(
                      child: IgnorePointer(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              /*Text(widget.locationPinText,
                                  style: widget.locationPinTextStyle,
                                  textAlign: TextAlign.center),*/
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Icon(
                                  widget.locationPinIcon,
                                  size: 50,
                                  color: widget.locationPinIconColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),


                  Positioned(
                    bottom: 60,
                    right: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: FloatingActionButton(
                            heroTag: 'btn1',
                            backgroundColor: Colors.white,
                            shape: StadiumBorder(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const GoToDesiredPosition(baseUri: 'https://nominatim.openstreetmap.org',)),
                              );
                            },
                            child: const Icon(
                              Icons.navigation_outlined,
                              color: Color(0xFF8E8E93),
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                           GestureDetector(
                             onTap: (){
                               _mapController.move(
                                   _mapController.center, _mapController.zoom + 1);
                             },
                             child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),

                                child: const Icon(
                                  Icons.add,
                                  color: Color(0xFF8E8E93),
                                  size: 30,
                                ),
                              ),
                           ),

                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: (){
                            _mapController.move(
                                _mapController.center, _mapController.zoom - 1);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),

                            child: const Icon(
                              Icons.remove,
                              color: Color(0xFF8E8E93),
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 65,
                          height: 65,
                          child: FloatingActionButton(
                            heroTag: 'btn3',
                            backgroundColor: const Color(0xFF7FB77E),
                            shape: const CircleBorder(),
                            onPressed: () async {
                              Position position = await determinePosition();
                              _mapController.move(LatLng(position.latitude, position.longitude), 12);
                              //getIt<MapRepositoryImpl>().getZone();
                            },
                            child: Icon(
                              widget.currentLocationIcon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*Positioned(

                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: widget.hintText,
                                border: inputBorder,
                                focusedBorder: inputFocusBorder,
                              ),
                              onChanged: (String value) {
                                if (_debounce?.isActive ?? false) {
                                  _debounce?.cancel();
                                }

                                _debounce = Timer(
                                    const Duration(milliseconds: 2000), () async {
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                  var client = http.Client();
                                  try {
                                    String url =
                                        '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                                    if (kDebugMode) {
                                      print(url);
                                    }
                                    var response = await client.get(Uri.parse(url));
                                    // var response = await client.post(Uri.parse(url));
                                    var decodedResponse =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                    as List<dynamic>;
                                    if (kDebugMode) {
                                      print(decodedResponse);
                                    }
                                    _options = decodedResponse
                                        .map(
                                          (e) => OSMdata(
                                        displayname: e['display_name'],
                                        lat: double.parse(e['lat']),
                                        lon: double.parse(e['lon']),
                                      ),
                                    )
                                        .toList();
                                    setState(() {});
                                  } finally {
                                    client.close();
                                  }

                                  setState(() {});
                                });
                              }),

                          StatefulBuilder(
                            builder: ((context, setState) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                _options.length > 5 ? 5 : _options.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_options[index].displayname),
                                    subtitle: Text(
                                        '${_options[index].lat},${_options[index].lon}'),
                                    onTap: () {
                                      _mapController.move(
                                          LatLng(_options[index].lat,
                                              _options[index].lon),
                                          15.0);

                                      _focusNode.unfocus();
                                      _options.clear();
                                      setState(() {});
                                    },
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),*/


                  Positioned(
                    top: 80,
                    right: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color:  Color(0xFF7FB77E),

                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                        const SizedBox(height: 8,),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return buildBottomSheet(context, _selectedCategories, (int index, bool value) {
                              setState(() {
                                if (value) {
                                  _selectedCategories.add(index);
                                } else {
                                  _selectedCategories.remove(index);
                                }
                              });
                            });
                          },
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.filter_list_alt,
                          color: Color(0xFF8E8E93),
                          size: 30,
                        ),
                      ),
                    ),
                        const SizedBox(height: 8,),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.border_all_outlined,
                            color: Color(0xFF8E8E93),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:   const ButtonNavigationBar(),
    )
          ],
        ),
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        '${widget.baseUri}/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    // var response = await client.post(Uri.parse(url));
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName, decodedResponse["address"]);
  }
}

class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;

  PickedData(this.latLong, this.addressName, this.address);
}