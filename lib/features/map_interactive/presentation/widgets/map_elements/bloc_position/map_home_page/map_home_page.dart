import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/bloc/zone_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_lots/lots_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/markers.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/map_home_page/map_home_page_controller.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/search_bar.dart';
import '../../../../../../../core/dependencies_injection.dart';
import '../../../../../../../main.dart';
import '../../../../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../../../bloc/zone_state.dart';
import '../../bloc_etablissement/etablissement_bloc.dart';
import '../position_bloc.dart';
import '../position_state.dart';
import '../../go_to_desired_position.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/domain/model/point_location.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';
class OpenStreetMapSearchAndPick extends StatefulWidget {
  static MapController mapController = MapController();

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
        this.locationPinIcon = Icons.location_on
   })
      : super(key: key);

  @override
  State<OpenStreetMapSearchAndPick> createState() =>
      OpenStreetMapSearchAndPickState();
}
class OpenStreetMapSearchAndPickState
    extends State<OpenStreetMapSearchAndPick> {
  static MapController mapController = MapController();

  /*********** Mode offline ***********/

  late CacheStore cacheStore;


  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<OSMdata> _options = <OSMdata>[];
  var client = http.Client();
  late Future<Position?> latlongFuture;

  void setNameCurrentPos() async {
    double latitude = mapController.center.latitude;
    double longitude = mapController.center.longitude;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    _searchController2.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  /*void setNameCurrentPosAtInit() async {
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
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    _searchController2.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    //setState(() {});
  }*/
  double? zoomUp ;
  LatLng? centerCamera ;
  int clickCount = 0;//
  bool displayEtablissemenst = true ;
  int clickCountEstablishment = 0;
  int clickCountSatellite = 0;
  double strokeWidthZone = 0;
  bool isFilledState = false;
  bool currrent_location_visibility = false ;
  String styleMap = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  bool markerVisibility = true ;
  bool roadLoaded = false ;
  @override
  void initState() {
    cacheStore = HiveCacheStore('default_path'); // Initialize cacheStore with a default path


    zoomUp = 15.5 ;//
     zoomUp = 15.5 ;//
     centerCamera = const LatLng(36.900264, 10.192354) ;
    mapController = MapController();

    //setNameCurrentPosAtInit();

    mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            '${widget.baseUri}/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.get(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
        as Map<dynamic, dynamic>;

        _searchController.text = decodedResponse['display_name'];
        _searchController2.text = decodedResponse['display_name'];

        setState(() {});

      }
    });


     super.initState();
  }
  bool _isFirstContainerClicked = false;
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
/****************************************/
  late LatLng myPoint;
  bool isLoading = false;
  List<LatLng>  points = [];

  PointLocation getCenter(PointLocation location1) {
    return PointLocation(lat: location1.lat, lng: location1.lng);
  }
  /*List<Point> getLotPositions(List<Lot> lots) {
    return lots.expand((lot) => lot.positions.expand((position) => [position]))
        .map((position) => Point(lat: position.lat, lng: position.lng))
        .toList();
  }*/

  Future<LatLng> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  Color getIconColor(int clickCountEstablishment) {
    if (clickCountEstablishment %2 !=0) {
      return Colors.red;
    } else {
      return Colors.transparent;
    }
  }


  @override
  Widget build(BuildContext context) {
    initDependencies() ;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
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
                                //bounds: LatLngBounds(const LatLng(36.903781, 10.190874),const LatLng(36.895888, 10.193448)),
                                /*maxBounds: LatLngBounds(const LatLng(36.904314, 10.190799),const LatLng(36.895590, 10.193497

                                )),*/
                                center: centerCamera,
                                zoom: zoomUp ?? 15.5,//
                                maxZoom: 25,
                                minZoom: 2,
                              ),
                              mapController: mapController,
                              children: [

                                TileLayer(//

                                  urlTemplate: styleMap,
                                  tileProvider: CachedTileProvider(
                                    //dio: _dio,
                                    maxStale: const Duration(days: 7),
                                    store: cacheStore,
                                    interceptors: [
                                      LogInterceptor(
                                        logPrint: (object) => getTemporaryDirectory().then((dir) {
                                          cacheStore = HiveCacheStore(dir.path);
                                          var cacheOptions = CacheOptions(
                                            store: cacheStore,
                                            hitCacheOnErrorExcept: [], // for offline behaviour
                                          );
                                          final dio = Dio()
                                            ..interceptors.add(
                                              DioCacheInterceptor(options: cacheOptions),
                                            );
                                          //dio.get(object.toString());
                                          //print('test ${object.toString()}');
                                        }),
                                        responseHeader: false,
                                        requestHeader: false,
                                        request: false,
                                      ),
                                    ],
                                  ),
                                  //https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png
                                  // https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}
                                  subdomains: const ['a', 'b', 'c'],
                                ),
                                /***********************/
                               /* BlocBuilder<EstablishmentBloc, EtablissementState>(
                                  builder: (context, state) {
                                    if(state is EtablissementSuccessState) {
                                      return MarkerLayer(

                                        markers: [
                                          for (int i = 0; i < state.etablissements.length; i++)
                                            Marker(
                                              width: 100.0,
                                              height: 100.0,
                                              point: latLngFromPoint(state.etablissements[i].position),
                                              //
                                              builder: (context) => GestureDetector(
                                                onTap: () {
                                                  showEstablishmentDialog(context, state.etablissements[i]);
                                                },
                                                child: const SizedBox(
                                                  width : 100,height : 100,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child:  Icon(
                                                          Icons.location_on,
                                                          size: 45,
                                                          color: Colors.red,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    }else {
                                      return Container();
                                    }

                                  },
                                ),*/
                                /**********************/

                                BlocBuilder<PositionBloc, PositionState>(
                                  builder: (context, state) {
                                    final osrm = Osrm();

                                    if (state is RoadState) {
                                     // if (clickCountEstablishment %2 !=0) {

                                      //}
                                      //clickCountEstablishment = 2 ;
                                      final options = RouteRequest(
                                        coordinates: [
                                          (state.location1.lng, state.location1.lat),
                                          (state.location2.lng, state.location2.lat),
                                        ],
                                      );

                                      return FutureBuilder(
                                        future: osrm.route(options),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            debugPrint('options are ${options.toString()}') ;
                                            return CircularProgressIndicator(); // Show a loading indicator while fetching data
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}'); // Show an error message if fetching data fails
                                          } else {

                                            List<Map<String, double>> road = snapshot.data!.routes.first.geometry!.lineString!.coordinates.map((e) {
                                              markers.clear();

                                                markers.add(
                                                  Marker(
                                                    width: 70.0,
                                                    height: 70.0,
                                                    point: latLngFromPoint(state.location1),
                                                    builder: (context) => GestureDetector(
                                                      child:  Column(
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.blue.withOpacity(0.4),
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

                                                );

                                              markers.add(
                                                Marker(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  point: latLngFromPoint(state.location2),
                                                  builder: (context) => GestureDetector(
                                                    child:  Column(
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

                                              );


                                              return e.toCoordinateMap();
                                            }).toList();

                                            List<LatLng> latLngList = road.map((e) => LatLng(e['lat']!, e['lng']!)).toList();
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
                                                MarkerLayer(
                                                  markers: markers,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      );
                                    }


                                    return Container(); // Return a placeholder if the state is not a RoadState
                                  },
                                ),
                                BlocBuilder<LotsBloc, LotsState>(
                                  builder: (context, state) {
                                    if (state is LotlistSuccessState) {
                                      return GestureDetector(
                                        onTap: (){
                                          debugPrint('Button pressed') ;
                                        },
                                        child: PolygonLayer(
                                          polygons: state.lots.map((lot) {
                                            debugPrint('lot');
                                            return drawPolygonForLots(pointsToLatLngs(lot.bordures), strokeWidthZone, isFilledState,lot.etat,lot.numero.toString(),clickCount);
                                          }).toList(),
                                        ),
                                      );
                                    } else {
                                      return Container(); // Return an empty container or any other fallback UI
                                    }
                                  },
                                ),
                                PolygonLayer(
                                  polygons: [
                                    drawPolygon(pointsToLatLngs(state.zone.bordures),strokeWidthZone,isFilledState),
                                  ],
                                ),
                                BlocBuilder<EstablishmentBloc, EtablissementState>(
                                  builder: (context, state) {
                                    if(state is EtablissementSuccessState) {
                                      return MarkerLayer(

                                        markers: [
                                          for (int i = 0; i < state.etablissements.length; i++)
                                            Marker(
                                              width: 100.0,
                                              height: 100.0,
                                              point: latLngFromPoint(state.etablissements[i].position),
                                              //
                                              builder: (context) => GestureDetector(
                                                onTap: () {
                                                  if (clickCountEstablishment %2 !=0) {
                                                    showEstablishmentDialog(context, state.etablissements[i]);
                                                  }
                                                  // foncusOntarget(mapController ,const LatLng(36.897295,10.194307, ));

                                                },
                                                child:  SizedBox(
                                                  width : 100,height : 100,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(

                                                          child: Icon(

                                                            Icons.location_on,
                                                            size: 45,
                                                            color: getIconColor(clickCountEstablishment),

                                                          ),

                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    }else {
                                      return Container();
                                    }

                                  },
                                ),



                              ],
                            );
                          } else if (state is ZoneErrorState) {
                            return Center(
                              child: Text("${state.errormessage}"),
                            );
                          } else {
                            // Handle other states if needed
                            return const Center(
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
                    baseUri: 'https://nominfatim.openstreetmap.org',
                    mapController: mapController,
                    searchController: _searchController,
                    focusNode: _focusNode,
                    options: _options,
                    debounce: Timer(Duration(milliseconds: 2000), () {}),
                  ),
                  /* Positioned.fill(
                      child: IgnorePointer(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                             /* Text(widget.locationPinText,
                                  style: widget.locationPinTextStyle,
                                  textAlign: TextAlign.center),*/
                              // Pink icon is here
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
                                widget.currentLocationIcon,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                            ],
                          ),
                        ),
                      )),*/

                  buildLocationPin(widget.currentLocationIcon,currrent_location_visibility),
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
                              /* _mapController.move(
                                   _mapController.center, _mapController.zoom + 1);*/
                               smoothZoomIn(mapController) ;

                             },
                             child: Container(
                               width: 48,
                               height: 48,
                               decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 borderRadius: const  BorderRadius.all(Radius.circular(10)),
                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(0.5),
                                     spreadRadius: 2,
                                     blurRadius: 5,
                                     offset: Offset(0, 2), // changes the position of the shadow
                                   ),
                                 ],
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
                            smoothZoomOut(mapController) ;
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // changes the position of the shadow
                                ),
                              ],
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
                              mapController.move(LatLng(position.latitude, position.longitude), 12);
                              setState(() {
                                currrent_location_visibility = true ;
                              });
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

                  Positioned(
                    top: 80,
                    right: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFirstContainerClicked = !_isFirstContainerClicked;
                            });
                          },
                          child: Container(

                            width: 48,
                            height: 48,
                            decoration:  BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // changes the position of the shadow
                                ),
                              ],
                              color: const Color(0xFF7FB77E),
                            ),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _isFirstContainerClicked,
                          child: const SizedBox(height: 8,),
                        ),
                        Visibility(
                          visible: _isFirstContainerClicked,
                          child: GestureDetector(
                            onTap: (){
                              clickCountEstablishment++;

                             // if (clickCountEstablishment %2 ==0) {
                                debugPrint('Show') ;
                                BlocProvider.of<EstablishmentBloc>(context).add(GetEtablissementEvent());
                            //  } else{
                                debugPrint('Not Show') ;
                                  /*setState(() {
                                    displayEtablissemenst = true ;//
                                  });*/
                                //BlocProvider.of<EstablishmentBloc>(context).add(SendEtablissemenEmptytEvent());
                                clickCount = 0;//
                              },
                             // debugPrint('Pressed') ;
                              //BlocProvider.of<EstablishmentBloc>(context).add(GetEtablissementEvent());
                          // },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration:  BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 2), // changes the position of the shadow
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Color(0xFF8E8E93),
                                size: 30,
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: _isFirstContainerClicked,
                          child: const SizedBox(height: 8,),
                        ),
                        Visibility(
                          visible: _isFirstContainerClicked,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<LotsBloc>(context).add(GetLotEvent());
                              setState(() {
                                if (clickCount % 2 == 0) {
                                  strokeWidthZone = 2;
                                  isFilledState = true;
                                  //styleMap = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}" ;
                                } else {
                                  strokeWidthZone = 0;
                                  isFilledState = false;//
                                }
                                clickCount++;
                              });
                            },
                            child: Container(

                              width: 48,
                              height: 48,
                              decoration:  BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2), // changes the position of the shadow
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.layers,
                                color: Color(0xFF8E8E93),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Visibility(
                          visible: _isFirstContainerClicked,//
                          child: GestureDetector(
                            onTap: () {

                              debugPrint('test pressed') ;


                              setState(() {
                                if (clickCountSatellite % 2 == 0) {
                                  // strokeWidthZone = 2;
                                  // isFilledState = true;
                                  styleMap = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}" ;
                                } else {
                                  strokeWidthZone = 0;
                                  isFilledState = false;
                                  styleMap = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" ;
                                }
                                clickCountSatellite++;
                              });
                            },                            child: Container(

                            width: 48,
                            height: 48,
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // changes the position of the shadow
                                ),
                              ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.satellite_alt_outlined,
                              color: Color(0xFF8E8E93),
                              size: 30,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             ButtonNavigationBar(),
          ],
        ),
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        mapController.center.latitude, mapController.center.longitude);
    var client = http.Client();
    String url =
        '${widget.baseUri}/reverse?format=json&lat=${mapController.center.latitude}&lon=${mapController.center.longitude}&zoom=18&addressdetails=1';

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