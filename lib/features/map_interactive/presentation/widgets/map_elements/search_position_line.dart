import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';
import '../../../../../core/connection_management.dart';
import 'bloc_position/map_home_page/map_home_page.dart';

class SearchBarLine extends StatefulWidget {
  final String hintText;
  final String baseUri;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final MapController mapController;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final Function(List<OSMdata>) updateOptions;
  // Add this callback


  List<OSMdata> options;
  Timer? debounce;

  SearchBarLine({
    Key? key,
    required this.hintText,
    required this.baseUri,
    required this.mapController,
    required this.searchController,
    required this.focusNode,
    required this.options,
    required this.debounce,
    required this.marginLeft,
    required this.marginRight,
    required this.marginTop,
    required this.updateOptions, // Pass the callback

  });

  @override
  _SearchBarState createState() => _SearchBarState();//
}

class _SearchBarState extends State<SearchBarLine> {
  Stream<bool> checkConnectionStream() async* {
    while (true) {
      yield await checkConnection();
      await Future.delayed(Duration(seconds: 1));
    }
  }
  @override
  Widget build(BuildContext context) {
    Stream<bool> connectionStream = checkConnectionStream();

    return Column(
      children: [
        Container(
          color: const Color(0xFFF5F5F5),
          child: StreamBuilder<bool>(
            stream: connectionStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(); // Or any other loading indicator
              }

              return TextFormField(
                controller: widget.searchController,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF7FB77E), // Change the color of the icon here
                  ),
                  enabled: snapshot.data ?? false, // Handle null value here
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (String value) {
                  if (widget.debounce?.isActive ?? false) {
                    widget.debounce?.cancel();
                  }

                  widget.debounce = Timer(
                    const Duration(milliseconds: 2000),
                        () async {
                      if (kDebugMode) {
                        print(value);
                      }
                      var client = http.Client();
                      try {
                        String url = '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                        if (kDebugMode) {
                          print(url);
                        }
                        var response = await client.get(Uri.parse(url));
                        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
                        if (kDebugMode) {
                          print(decodedResponse);
                        }
                        widget.options = decodedResponse
                            .map(
                              (e) => OSMdata(
                            displayname: e['display_name'],
                            lat: double.parse(e['lat']),
                            lon: double.parse(e['lon']),
                          ),
                        )
                            .toList();
                        widget.updateOptions(widget.options); // Call the callback to update options

                        setState(() {});
                      } finally {
                        client.close();
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
        /*StatefulBuilder(
          builder: (context, setState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.options.length > 5 ? 5 : widget.options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.options[index].displayname),
                  subtitle: Text('${widget.options[index].lat},${widget.options[index].lon}'),
                  onTap: () {
                    widget.mapController.move(
                      LatLng(widget.options[index].lat, widget.options[index].lon),
                      15.0,
                    );

                    widget.focusNode.unfocus();
                    widget.options.clear();
                    setState(() {});
                  },
                );
              },
            );
          },
        ),*/
      ],
    );  }
}