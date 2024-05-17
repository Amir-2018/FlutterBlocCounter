// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/markers.dart';

import '../../features/evenements/presentation/event/bloc/evenement_bloc.dart';
import '../../features/evenements/presentation/event/event_widget.dart';
import '../../features/map_interactive/domain/model/point_location.dart';
import '../../features/map_interactive/presentation/widgets/map_elements/bloc_etablissement/etablissement_bloc.dart';
import '../../features/map_interactive/presentation/widgets/map_elements/wide_button.dart';

class MapPopUP extends StatefulWidget {
  final void Function(PickedData pickedData) onPicked;
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

  const MapPopUP({
    Key? key,
    required this.onPicked,
    this.zoomOutIcon = Icons.remove,
    this.zoomInIcon = Icons.add,
    this.currentLocationIcon = Icons.my_location,
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
    this.locationPinIcon = Icons.location_on,
  }) : super(key: key);

  @override
  State<MapPopUP> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState
    extends State<MapPopUP> {
  List<Marker> markerstable = [] ; 
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Timer? _debounce;
  var client = http.Client();
  late Future<PointLocation?> latlongFuture;

  Future<Position?> getCurrentPosLatLong() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    /// do not have location permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return await getPosition(locationPermission);
    }

    /// have location permission
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }
  void _onPositionChanged(MapPosition position, bool hasGesture) {
    if (hasGesture) {
      setState(() {
        EventWidget.nomPosition ='${position.center!.latitude.toString()+','+position.center!.longitude.toString()}'  ;
        print('position 3andy ${EventWidget.nomPosition}');
      });
    }
  }
  Future<Position?> getPosition(LocationPermission locationPermission) async {
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

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
    setState(() {});
  }

  void setNameCurrentPosAtInit(double latitude, double longitude) async {
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
  }
  Future<PointLocation?> fetchPositionAsync() async {
    // Ici, vous auriez normalement une logique pour récupérer la position
    // Par exemple, une requête réseau ou une lecture de données locales
    return PointLocation(lat: 10, lng: 10); // Retourne une position fictive
  }
  @override
  void initState() {
    latlongFuture = fetchPositionAsync();

    BlocProvider.of<EstablishmentBloc>(context).add(
        SendEtablissementLocalEvent()
    );  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String? _autocompleteSelection;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 3.0),
    );
    return FutureBuilder<PointLocation?>(
      future: latlongFuture,
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.lat, snapshot.data!.lng
          );
        }
        return SafeArea(
          child: Stack(
            children: [
             /* Positioned.fill(
                child: BlocListener<EstablishmentBloc, EtablissementState>(
                      listener: (context, state) {
                        if (state is EtablissementSuccessLocalState) {

                          for (var i = 0; i < state.etablissements.length; i++) {
                            Marker marker = Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(state.etablissements[i].position.lat, state.etablissements[i].position.lng), // Coordonnées du marqueur
                              builder: (ctx) => GestureDetector(child:const Icon(Icons.location_on, size: 40.0,color: Color(0xff000000),),onTap: (){
                                BlocProvider.of<EstablishmentBloc>(context).add(
                                    SendEtablissementLocalEvent()
                                );
                              },) // Ajoutez un icône ici
                            );
                            setState(() {
                              markerstable.add(marker);
                            });
                            print('length = ${markerstable.length}');
                          }



                        }else{
                          print('Nooooooo');
                        }

                      },
                      child:*/ FlutterMap(

                  options: MapOptions(
                      onPositionChanged: _onPositionChanged,

                      center: LatLng(36.899972, 10.192783), zoom: 15.0, maxZoom: 18, minZoom: 6),
                  mapController: _mapController,
                  children: [
                    TileLayer(
                      urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      // attributionBuilder: (_) {
                      //   return Text("© OpenStreetMap contributors");
                      // },
                    ),
                    MarkerLayer(markers: markerstable), // Ajoutez le MarkerLayer ici

                  ],
                ),




                 Positioned.fill(
                  child: IgnorePointer(
                    child: GestureDetector(

                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                    ),
                  ),
                ),



            ],
          ),
        );
      },
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