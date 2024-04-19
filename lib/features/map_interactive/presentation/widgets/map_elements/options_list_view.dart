import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_bloc.dart';
import 'package:pfechotranasmartvillage/features/map_interactive/presentation/widgets/map_elements/bloc_position/position_event.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/model/point_location.dart';
import 'bloc_position/position_state.dart';
import 'map_home_page.dart';

class OptionsListView extends StatefulWidget {
  final List<OSMdata> options;
  final MapController mapController;
  final FocusNode focusNode;

  const OptionsListView({
    Key? key,
    required this.options,
    required this.mapController,
    required this.focusNode,
  }) : super(key: key);

  @override
  _OptionsListViewState createState() => _OptionsListViewState();
}

class _OptionsListViewState extends State<OptionsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (context, setState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.options.length > 5 ? 5 : widget.options.length,
            itemBuilder: (context, index) {
              if (index == widget.options.length) {
                return const CircularProgressIndicator();
              }

              return Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5), // Background color F5F5F5
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Color(0xFFC91C1C)),

                  title: Text(widget.options[index].displayname),
                  subtitle: Text('${widget.options[index].lat},${widget.options[index].lon}'),
                  onTap: () {
                    DestinationPosition destDataObj = DestinationPosition(
                      widget.options[index].displayname,
                      PointLocation(lat : widget.options[index].lat, lng : widget.options[index].lon),
                    );

                    BlocProvider.of<PositionBloc>(context).add(
                      GetPositionEvent(destinationData: destDataObj),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}